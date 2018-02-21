#!/bin/bash


# export LD_LIBRARY_PATH=/usr/lib/gcc/x86_64-linux-gnu/5/:$LD_LIBRARY_PATH
# export ACC_DEVICE_TYPE=host

# singularity pull docker://nvidia/opencl

IMAGE_PATH="$HOME/opencl.img"
# IMAGE_PATH="$HOME/ruycastilho-GPUtest-master.simg"
ROOT_DIR="$HOME/OpenCL-seismic-processing-tiago/"
DATASET="$HOME/seismic-data/fold1000.su"
# DATASET="$HOME/Data/701-jequit-Data-Mute-Attenuation.su"
# DATASET="$HOME/Data/simple-syntetic-micro_sorted.su"
# DATASET="$HOME/Data/simple-synthetic.su"
DATA=${DATASET##*/}
DATA=${DATA%.su}


REPETITIONS=3

OPENACC=

declare -a DIRECTORIES=("CMP/CUDA" "CMP/CUDAfp16" "CMP/OpenACC" "CMP/OpenMP")
declare -a NAMES=("CMP-CUDA" "CMP-CUDAfp16" "CMP-OpenACC" "CMP-OpenMP")
declare -a EXECUTABLES=("cmp-cuda" "cmp-cudafp16" "cmp-acc" "cmp-omp2")

declare -a TYPES=("host" "singularity")

PARAM_A0="-8e-4"
PARAM_A1="8e-4"
PARAM_B0="-1e-7"
PARAM_B1="1e-7"
PARAM_C0="2e-6"
PARAM_C1="4.4e-7"
PARAM_NA="5"
PARAM_NB="5"
PARAM_NC="5"
PARAM_APH="600"
PARAM_APM="50"
PARAM_TAU="0.002"
PARAM_D="1"
PARAM_V="4"

mkdir ${ROOT_DIR}/Result

clinfo > ${ROOT_DIR}/Result/clinfo

for benchmark in `seq 1 ${#NAMES[@]}`; do
	NAME=${NAMES[benchmark]}
	echo "Executing $NAME..."
	EXECUTABLE=bin/${EXECUTABLES[benchmark]}
	cd ${ROOT_DIR}/${DIRECTORIES[benchmark]}
	echo "Going to run $NAME $EXECUTABLE on $PWD"
	if [ ! -e ${EXECUTABLE} ]; then
	  echo "Excecutable $EXECUTABLE not found"
	  continue
	fi

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-nc ${PARAM_NC} \
	-aph ${PARAM_APH} \
	-tau ${PARAM_TAU} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_output.txt" \
	2> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
singularity exec --nv $IMAGE_PATH ./execute_singularity.sh
# rm execute_*.sh
done



#CMP-OpenCL
NAME=CMP-OpenCL
echo "Executing $NAME..."
EXECUTABLE=bin/cmp-ocl2
cd ${ROOT_DIR}/CMP/OpenCL

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
	for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-nc ${PARAM_NC} \
	-aph ${PARAM_APH} \
	-tau ${PARAM_TAU} \
	-d ${PARAM_D} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_output.txt" \
	2> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
singularity exec --nv $IMAGE_PATH ./execute_singularity.sh
# rm execute_*.sh


#CRS-CUDA
NAME=CRS-CUDA
	echo "Executing $NAME..."
EXECUTABLE=bin/crs-cuda
cd ${ROOT_DIR}/CRS/CUDA

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
	for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
	-a0 ${PARAM_A0} \
	-a1 ${PARAM_A1} \
	-na ${PARAM_NA} \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-nc ${PARAM_NC} \
	-b0 ${PARAM_B0} \
	-b1 ${PARAM_B1} \
	-nb ${PARAM_NB} \
	-aph ${PARAM_APH} \
	-apm ${PARAM_APM} \
	-tau ${PARAM_TAU} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_output.txt" \
	2> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
singularity exec --nv $IMAGE_PATH ./execute_singularity.sh
# rm execute_*.sh


if [[ ! -z "${OPENACC}" ]]; then

	#CRS-OpenACC
	NAME=CRS-OpenACC
	echo "Executing $NAME..."
	EXECUTABLE=bin/crs-acc
	cd ${ROOT_DIR}/CRS/OpenACC

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
	for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
	-a0 ${PARAM_A0} \
	-a1 ${PARAM_A1} \
	-na ${PARAM_NA} \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-nc ${PARAM_NC} \
	-b0 ${PARAM_B0} \
	-b1 ${PARAM_B1} \
	-nb ${PARAM_NB} \
	-aph ${PARAM_APH} \
	-apm ${PARAM_APM} \
	-tau ${PARAM_TAU} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_output.txt" \
	2> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
singularity exec --nv $IMAGE_PATH ./execute_singularity.sh
# rm execute_*.sh
fi

#CRS-OpenCL
NAME=CRS-OpenCL
	echo "Executing $NAME..."
EXECUTABLE=bin/crs-ocl2
cd ${ROOT_DIR}/CRS/OpenCL

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
	for i in \`seq 1 $REPETITIONS\`; do
		time ( ./$EXECUTABLE \
		-a0 ${PARAM_A0} \
		-a1 ${PARAM_A1} \
		-na ${PARAM_NA} \
		-c0 ${PARAM_C0} \
		-c1 ${PARAM_C1} \
		-nc ${PARAM_NC} \
		-b0 ${PARAM_B0} \
		-b1 ${PARAM_B1} \
		-nb ${PARAM_NB} \
		-aph ${PARAM_APH} \
		-apm ${PARAM_APM} \
		-tau ${PARAM_TAU} \
		-d ${PARAM_D} \
		-v ${PARAM_V} \
		-i $DATASET ) \
		>> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_output.txt" \
		2> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt"
	done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
singularity exec --nv $IMAGE_PATH ./execute_singularity.sh
# rm execute_*.sh

#CRS-OpenMP
NAME=CRS-OpenMP
	echo "Executing $NAME..."
EXECUTABLE=bin/crs-omp2
cd ${ROOT_DIR}/CRS/OpenMP

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
	for i in \`seq 1 $REPETITIONS\`; do
		time ( ./$EXECUTABLE \
		-a0 ${PARAM_A0} \
		-a1 ${PARAM_A1} \
		-na ${PARAM_NA} \
		-c0 ${PARAM_C0} \
		-c1 ${PARAM_C1} \
		-nc ${PARAM_NC} \
		-b0 ${PARAM_B0} \
		-b1 ${PARAM_B1} \
		-nb ${PARAM_NB} \
		-aph ${PARAM_APH} \
		-apm ${PARAM_APM} \
		-tau ${PARAM_TAU} \
		-v ${PARAM_V} \
		-i $DATASET ) \
		>> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_output.txt" \
		2> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt"
	done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
singularity exec --nv $IMAGE_PATH ./execute_singularity.sh
# rm execute_*.sh

if [[ ! -z "${OPENACC}" ]]; then

	#CRS-DE-OpenACC
	NAME=CRS-DE-OpenACC
	echo "Executing $NAME..."
	EXECUTABLE=bin/crs-acc-de
	cd ${ROOT_DIR}/CRS/OpenACC

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
	-ngen 30 \
	-a0 ${PARAM_A0} \
	-a1 ${PARAM_A1} \
	-na ${PARAM_NA} \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-nc ${PARAM_NC} \
	-b0 ${PARAM_B0} \
	-b1 ${PARAM_B1} \
	-nb ${PARAM_NB} \
	-aph ${PARAM_APH} \
	-apm ${PARAM_APM} \
	-tau ${PARAM_TAU} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_output.txt" \
	2> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
singularity exec --nv $IMAGE_PATH ./execute_singularity.sh
# rm execute_*.sh
fi


#CRS-DE-OpenCL
NAME=CRS-DE-OpenCL
echo "Executing $NAME..."
EXECUTABLE=bin/crs-ocl-de
cd ${ROOT_DIR}/CRS-DE/OpenCL

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
	-ngen 30 \
	-azimuth 0 \
	-a0 ${PARAM_A0} \
	-a1 ${PARAM_A1} \
	-na ${PARAM_NA} \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-nc ${PARAM_NC} \
	-b0 ${PARAM_B0} \
	-b1 ${PARAM_B1} \
	-nb ${PARAM_NB} \
	-aph ${PARAM_APH} \
	-apm ${PARAM_APM} \
	-tau ${PARAM_TAU} \
	-d ${PARAM_D} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_output.txt" \
	2> "${ROOT_DIR}/Result/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
singularity exec --nv $IMAGE_PATH ./execute_singularity.sh
# rm execute_*.sh

cd ${ROOT_DIR}
ls Result

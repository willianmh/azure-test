#!/bin/bash

export ACC_DEVICE_TYPE=host
IMAGE_PATH="/home/username/ruycastilho-GPUtest-master.simg"
ROOT_DIR="/home/username/OpenCL-seismic-processing-tiago/"
# DATASET="/home/username/Data/fold200.sgy"
DATASET="/home/username/Data/701-jequit-Data-Mute-Attenuation.su"
# DATASET="/home/username/Data/simple-syntetic-micro_sorted.su"
# DATASET="/home/username/Data/simple-synthetic.su"
DATA=${DATASET##*/}
DATA=${DATA%.su}

REPETITIONS=5

OPENACC=

declare -a DIRECTORIES=("CMP/CUDA" "CMP/CUDAfp16" "CMP/OpenACC" "CMP/OpenMP")
declare -a NAMES=("CMP-CUDA" "CMP-CUDAfp16" "CMP-OpenACC" "CMP-OpenMP")
declare -a EXECUTABLES=("cmp-cuda" "cmp-cudafp16" "cmp-acc" "cmp-omp2" )

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

clinfo > ${ROOT_DIR}/Result/clinfo

for benchmark in `seq 1 ${#NAMES[@]}`; do
	NAME=${NAMES[benchmark]}
	EXECUTABLE=bin/${EXECUTABLES[benchmark]}
	cd ${ROOT_DIR}/${DIRECTORIES[benchmark]}
	echo "Going to run $NAME $EXECUTABLE on $PWD"
	if [ ! -e ${EXECUTABLE} ]; then
	  echo "Excecutable $EXECUTABLE not found"
	  continue
	fi
	TYPE=host
	for i in 1 .. $REPETITIONS; do
		time ( ./$EXECUTABLE \
		-c0 ${PARAM_C0} \
		-c1 ${PARAM_C1} \
		-nc ${PARAM_NC} \
		-aph ${PARAM_APH} \
		-tau ${PARAM_TAU} \
		-v ${PARAM_V} \
		-i $DATASET ) \
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
		2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
	done

TYPE=singularity
cat << EOF > execute.sh
#!/bin/bash
for i in 1 .. $REPETITIONS; do
	time ( ./$EXECUTABLE \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-nc ${PARAM_NC} \
	-aph ${PARAM_APH} \
	-tau ${PARAM_TAU} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
	2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
done
EOF
chmod +x execute.sh
singularity exec --nv $IMAGE_PATH ./execute.sh
rm execute.sh
done



#CMP-OpenCL
NAME=CMP-OpenCL
EXECUTABLE=bin/cmp-ocl2
cd ${ROOT_DIR}/CMP/OpenCL

TYPE=host

for i in 1 .. $REPETITIONS; do
	time ( ./$EXECUTABLE \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-nc ${PARAM_NC} \
	-aph ${PARAM_APH} \
	-tau ${PARAM_TAU} \
	-d ${PARAM_D} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
	2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
done

TYPE=singularity

cat << EOF > execute.sh
#!/bin/bash
	for i in 1 .. $REPETITIONS; do
	time ( ./$EXECUTABLE \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-nc ${PARAM_NC} \
	-aph ${PARAM_APH} \
	-tau ${PARAM_TAU} \
	-d ${PARAM_D} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
	2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
done
EOF
chmod +x execute.sh
singularity exec --nv $IMAGE_PATH ./execute.sh
rm execute.sh


#CRS-CUDA
NAME=CRS-CUDA
EXECUTABLE=bin/crs-cuda
cd ${ROOT_DIR}/CRS/CUDA

TYPE=host

for i in 1 .. $REPETITIONS; do
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
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
	2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
done

TYPE=singularity

cat << EOF > execute.sh
#!/bin/bash
	for i in 1 .. $REPETITIONS; do
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
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
	2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
done
EOF
chmod +x execute.sh
singularity exec --nv $IMAGE_PATH ./execute.sh
rm execute.sh


if [[ ! -z "${OPENACC}" ]]; then

	#CRS-OpenACC
	NAME=CRS-OpenACC
	EXECUTABLE=bin/crs-acc
	cd ${ROOT_DIR}/CRS/OpenACC

	TYPE=host

	for i in 1 .. $REPETITIONS; do
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
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
		2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
	done

	TYPE=singularity

		cat << EOF > execute.sh
		#!/bin/bash
		for i in 1 .. $REPETITIONS; do
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
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
		2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
	done
EOF
chmod +x execute.sh
singularity exec --nv $IMAGE_PATH ./execute.sh
rm execute.sh
fi

#CRS-OpenCL
NAME=CRS-OpenCL
EXECUTABLE=bin/crs-ocl2
cd ${ROOT_DIR}/CRS/OpenCL

TYPE=host

for i in 1 .. $REPETITIONS; do
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
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
	2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
done

TYPE=singularity

cat << EOF > execute.sh
#!/bin/bash
	for i in 1 .. $REPETITIONS; do
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
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
		2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
	done
EOF
chmod +x execute.sh
singularity exec --nv $IMAGE_PATH ./execute.sh
rm execute.sh

#CRS-OpenMP
NAME=CRS-OpenMP
EXECUTABLE=bin/crs-omp2
cd ${ROOT_DIR}/CRS/OpenMP

TYPE=host

for i in 1 .. $REPETITIONS; do
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
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
	2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
done

TYPE=singularity

cat << EOF > execute.sh
#!/bin/bash
	for i in 1 .. $REPETITIONS; do
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
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
		2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
	done
EOF
chmod +x execute.sh
singularity exec --nv $IMAGE_PATH ./execute.sh
rm execute.sh

if [[ ! -z "${OPENACC}" ]]; then

	#CRS-DE-OpenACC
	NAME=CRS-DE-OpenACC
	EXECUTABLE=bin/crs-acc-de
	cd ${ROOT_DIR}/CRS/OpenACC

	TYPE=host

	for i in 1 .. $REPETITIONS; do
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
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
	2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
	done

	TYPE=singularity

		cat << EOF > execute.sh
		#!/bin/bash
	for i in 1 .. $REPETITIONS; do
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
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
		2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
	done
EOF
chmod +x execute.sh
singularity exec --nv $IMAGE_PATH ./execute.sh
rm execute.sh
fi


#CRS-DE-OpenCL
NAME=CRS-DE-OpenCL
EXECUTABLE=bin/crs-ocl-de
cd ${ROOT_DIR}/CRS-DE/OpenCL

TYPE=host

for i in 1 .. $REPETITIONS; do
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
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
	2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
done

TYPE=singularity

cat << EOF > execute.sh
#!/bin/bash
	for i in 1 .. $REPETITIONS; do
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
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}_time.txt \
		2> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC}.txt
	done
EOF
chmod +x execute.sh
singularity exec --nv $IMAGE_PATH ./execute.sh
rm execute.sh




# Original
# time ( ./$EXECUTABLE \
# -ngen 30 \
# -azimuth 0 \
# -a0 -0.7e-3 \
# -a1 0.7e-3 \
# -na 5 \
# -c0 1.98e-7 \
# -c1 1.77e-6 \
# -nc 5 \
# -b0 -1e-7 \
# -b1 1e-7 \
# -nb 5 \
# -aph 600 \
# -apm 50 \
# -tau 0.002 \
# -d 1 \
# -v 4 \
# -i $DATASET \


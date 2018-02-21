#!/bin/bash

export ACC_DEVICE_TYPE=host
IMAGE_PATH="/home/username/ruycastilho-GPUtest-master.simg"
ROOT_DIR="/home/username/OpenCL-seismic-processing-tiago/"
DATASET="/home/username/Data/701-jequit-Data-Mute-Attenuation.su"
# DATASET="/home/username/Data/simple-syntetic-micro_sorted.su"
# DATASET="/home/username/Data/simple-synthetic.su"
DATA=${DATASET##*/}
DATA=${DATA%.su}

OPENACC=

declare -a DIRECTORIES=("CMP/CUDA" "CMP/CUDAfp16" "CMP/OpenACC" "CMP/OpenMP")
declare -a NAMES=("CMP-CUDA" "CMP-CUDAfp16" "CMP-OpenACC" "CMP-OpenMP")
declare -a EXECUTABLES=("cmp-cuda" "cmp-cudafp16" "cmp-acc" "cmp-omp2" )

declare -a TYPES=("host" "singularity")
REPETITIONS=10

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
		./$EXECUTABLE \
		-c0 1.98e-7 \
		-c1 1.77e-6 \
		-nc 5 \
		-aph 600 \
		-tau 0.002 \
		-v 4 \
		-i $DATASET \
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
	done
	TYPE=singularity
	singularity exec --nv $IMAGE_PATH bash -c "\
		for i in 1 .. $REPETITIONS; do
			./$EXECUTABLE \
			-c0 1.98e-7 \
			-c1 1.77e-6 \
			-nc 5 \
			-aph 600 \
			-tau 0.002 \
			-v 4 \
			-i $DATASET \
			>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
		done "
done



#CMP-OpenCL
NAME=CMP-OpenCL
EXECUTABLE=bin/cmp-ocl2
cd ${ROOT_DIR}/CMP/OpenCL

TYPE=host

for i in 1 .. $REPETITIONS; do
	./$EXECUTABLE \
	-ngen 30 \
	-c0 1.98e-7 \
	-c1 1.77e-6 \
	-nc 5 \
	-aph 600 \
	-tau 0.002 \
	-d 1 \
	-v 4 \
	-i $DATASET \
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
done

TYPE=singularity

singularity exec --nv $IMAGE_PATH bash -c "\
	for i in 1 .. $REPETITIONS; do
	./$EXECUTABLE \
	-c0 1.98e-7 \
	-c1 1.77e-6 \
	-nc 5 \
	-aph 600 \
	-tau 0.002 \
	-d 1 \
	-v 4 \
	-i $DATASET \
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
done"


#CRS-CUDA
NAME=CRS-CUDA
EXECUTABLE=bin/crs-cuda
cd ${ROOT_DIR}/CRS/CUDA

TYPE=host

for i in 1 .. $REPETITIONS; do
	./$EXECUTABLE \
	-a0 -0.7e-3 \
	-a1 0.7e-3 \
	-na 5 \
	-c0 1.98e-7 \
	-c1 1.77e-6 \
	-nc 5 \
	-b0 -1e-7 \
	-b1 1e-7 \
	-nb 5 \
	-aph 600 \
	-apm 50 \
	-tau 0.002 \
	-v 4 \
	-i $DATASET \
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
done

TYPE=singularity

singularity exec --nv $IMAGE_PATH bash -c "\
	for i in 1 .. $REPETITIONS; do
	./$EXECUTABLE \
	-a0 -0.7e-3 \
	-a1 0.7e-3 \
	-na 5 \
	-c0 1.98e-7 \
	-c1 1.77e-6 \
	-nc 5 \
	-b0 -1e-7 \
	-b1 1e-7 \
	-nb 5 \
	-aph 600 \
	-apm 50 \
	-tau 0.002 \
	-v 4 \
	-i $DATASET \
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
done"


if [[ -z "${OPENACC}" ]]; then

	#CRS-OpenACC
	NAME=CRS-OpenACC
	EXECUTABLE=bin/crs-acc
	cd ${ROOT_DIR}/CRS/OpenACC

	TYPE=host

	for i in 1 .. $REPETITIONS; do
		./$EXECUTABLE \
		-a0 -0.7e-3 \
		-a1 0.7e-3 \
		-na 5 \
		-c0 1.98e-7 \
		-c1 1.77e-6 \
		-nc 5 \
		-b0 -1e-7 \
		-b1 1e-7 \
		-nb 5 \
		-aph 600 \
		-apm 50 \
		-tau 0.002 \
		-v 4 \
		-i $DATASET \
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
	done

	TYPE=singularity

	singularity exec --nv $IMAGE_PATH bash -c "\
		for i in 1 .. $REPETITIONS; do
		./$EXECUTABLE \
		-a0 -0.7e-3 \
		-a1 0.7e-3 \
		-na 5 \
		-c0 1.98e-7 \
		-c1 1.77e-6 \
		-nc 5 \
		-b0 -1e-7 \
		-b1 1e-7 \
		-nb 5 \
		-aph 600 \
		-apm 50 \
		-tau 0.002 \
		-v 4 \
		-i $DATASET \
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
	done"
fi

#CRS-OpenCL
NAME=CRS-OpenCL
EXECUTABLE=bin/crs-ocl2
cd ${ROOT_DIR}/CRS/OpenCL

TYPE=host

for i in 1 .. $REPETITIONS; do
	./$EXECUTABLE \
	-a0 -0.7e-3 \
	-a1 0.7e-3 \
	-na 5 \
	-c0 1.98e-7 \
	-c1 1.77e-6 \
	-nc 5 \
	-b0 -1e-7 \
	-b1 1e-7 \
	-nb 5 \
	-aph 600 \
	-apm 50 \
	-tau 0.002 \
	-d 1 \
	-v 4 \
	-i $DATASET \
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
done

TYPE=singularity

singularity exec --nv $IMAGE_PATH bash -c "\
	for i in 1 .. $REPETITIONS; do
		./$EXECUTABLE \
		-a0 -0.7e-3 \
		-a1 0.7e-3 \
		-na 5 \
		-c0 1.98e-7 \
		-c1 1.77e-6 \
		-nc 5 \
		-b0 -1e-7 \
		-b1 1e-7 \
		-nb 5 \
		-aph 600 \
		-apm 50 \
		-tau 0.002 \
		-d 1 \
		-v 4 \
		-i $DATASET \
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
	done"

#CRS-OpenMP
NAME=CRS-OpenMP
EXECUTABLE=bin/crs-omp2
cd ${ROOT_DIR}/CRS/OpenMP

TYPE=host

for i in 1 .. $REPETITIONS; do
	./$EXECUTABLE \
	-a0 -0.7e-3 \
	-a1 0.7e-3 \
	-na 5 \
	-c0 1.98e-7 \
	-c1 1.77e-6 \
	-nc 5 \
	-b0 -1e-7 \
	-b1 1e-7 \
	-nb 5 \
	-aph 600 \
	-apm 50 \
	-tau 0.002 \
	-v 4 \
	-i $DATASET \
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
done

TYPE=singularity

singularity exec --nv $IMAGE_PATH bash -c "\
	for i in 1 .. $REPETITIONS; do
		./$EXECUTABLE \
		-a0 -0.7e-3 \
		-a1 0.7e-3 \
		-na 5 \
		-c0 1.98e-7 \
		-c1 1.77e-6 \
		-nc 5 \
		-b0 -1e-7 \
		-b1 1e-7 \
		-nb 5 \
		-aph 600 \
		-apm 50 \
		-tau 0.002 \
		-v 4 \
		-i $DATASET \
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
	done"

if [[ -z "${OPENACC}" ]]; then

	#CRS-DE-OpenACC
	NAME=CRS-DE-OpenACC
	EXECUTABLE=bin/crs-acc-de
	cd ${ROOT_DIR}/CRS/OpenACC

	TYPE=host

	for i in 1 .. $REPETITIONS; do
	./$EXECUTABLE \
	-ngen 30 \
	-a0 -0.7e-3 \
	-a1 0.7e-3 \
	-na 5 \
	-c0 1.98e-7 \
	-c1 1.77e-6 \
	-nc 5 \
	-b0 -1e-7 \
	-b1 1e-7 \
	-nb 5 \
	-aph 600 \
	-apm 50 \
	-tau 0.002 \
	-v 4 \
	-i $DATASET \
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
	done

	TYPE=singularity

	singularity exec --nv $IMAGE_PATH bash -c "\
	for i in 1 .. $REPETITIONS; do
		./$EXECUTABLE \
		-ngen 30 \
		-a0 -0.7e-3 \
		-a1 0.7e-3 \
		-na 5 \
		-c0 1.98e-7 \
		-c1 1.77e-6 \
		-nc 5 \
		-b0 -1e-7 \
		-b1 1e-7 \
		-nb 5 \
		-aph 600 \
		-apm 50 \
		-tau 0.002 \
		-v 4 \
		-i $DATASET \
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
	done"
fi


#CRS-DE-OpenCL
NAME=CRS-DE-OpenCL
EXECUTABLE=bin/crs-ocl-de
cd ${ROOT_DIR}/CRS-DE/OpenCL

TYPE=host

for i in 1 .. $REPETITIONS; do
	./$EXECUTABLE \
	-ngen 30 \
	-azimuth 0 \
	-a0 -0.7e-3 \
	-a1 0.7e-3 \
	-na 5 \
	-c0 1.98e-7 \
	-c1 1.77e-6 \
	-nc 5 \
	-b0 -1e-7 \
	-b1 1e-7 \
	-nb 5 \
	-aph 600 \
	-apm 50 \
	-tau 0.002 \
	-d 1 \
	-v 4 \
	-i $DATASET \
	>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
done

TYPE=singularity

singularity exec --nv $IMAGE_PATH bash -c "\
	for i in 1 .. $REPETITIONS; do
		./$EXECUTABLE \
		-ngen 30 \
		-azimuth 0 \
		-a0 -0.7e-3 \
		-a1 0.7e-3 \
		-na 5 \
		-c0 1.98e-7 \
		-c1 1.77e-6 \
		-nc 5 \
		-b0 -1e-7 \
		-b1 1e-7 \
		-nb 5 \
		-aph 600 \
		-apm 50 \
		-tau 0.002 \
		-d 1 \
		-v 4 \
		-i $DATASET \
		>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE"_${DATA}.txt
	done"

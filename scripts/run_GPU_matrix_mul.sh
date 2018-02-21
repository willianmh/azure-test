#!/bin/bash

# declare -a SIZES ( 12800 )

REPETITIONS=3
SIZE=12800
RESULT_DIR="results_matrix"
IMAGE_PATH="ruycastilho-GPUtest-master.simg"



rm -rf ${RESULT_DIR}
mkdir -f ${RESULT_DIR}

for i in `seq 1 $REPETITIONS`; do
	./minimal $SIZE &>> ${RESULT_DIR}/OpenCL_host.output
	singularity exec --nv $IMAGE_PATH ./minimal $SIZE &>> ${RESULT_DIR}/OpenCL_singularity.output
	./matrixMul -device=2 -wA=$SIZE -xB=$SIZE -hA=$SIZE -hB=$SIZE &>> ${RESULT_DIR}/CUDA_host.output
	singularity exec --nv $IMAGE_PATH ./matrixMul -device=2 -wA=$SIZE -xB=$SIZE -hA=$SIZE -hB=$SIZE &>> ${RESULT_DIR}/CUDA_singularity.output
done
#!/bin/bash

# declare -a SIZES ( 12800 )

REPETITIONS=5
SIZE=12800
RESULT_DIR="results_matrix"
IMAGE_PATH="$HOME/ruycastilho-GPUtest-master.simg"

rm -rf ${RESULT_DIR}
mkdir ${RESULT_DIR}
clinfo > ${RESULT_DIR}/clinfo

for i in `seq 1 $REPETITIONS`; do
	./mult_opencl.sh $SIZE &>> ${RESULT_DIR}/OpenCL_host_${i}.output
	singularity exec --nv $IMAGE_PATH ./mult_opencl.sh $SIZE &>> ${RESULT_DIR}/OpenCL_singularity_${i}.output
	./mult_cuda.sh $SIZE &>> ${RESULT_DIR}/CUDA_host_${i}.output
	singularity exec --nv $IMAGE_PATH ./mult_cuda.sh $SIZE &>> ${RESULT_DIR}/CUDA_singularity_${i}.output
done

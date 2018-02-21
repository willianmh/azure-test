#!/bin/bash
# - - - - - - - - GPU - - - - - - - - - -
RESULT_DIR=results_gpu_`date +%d_%m_%y`_X
SERVER_IP=""

mkdir ${RESULT_DIR}
scp -r username@${SERVER_IP}:/home/username/OpenCL-seismic-processing-tiago/Result ${RESULT_DIR}

cd ${RESULT_DIR}
for i in *; do
	if [[  -d "$i" ]] && [[ ! -e result_${i}.txt ]]; then
		find $i -type f -print -iname "*.txt" -exec sh -c "cat {} | grep 'Execution Time'" \; > result_${i}.txt
	fi
done



# - - - - - - - - MPI - - - - - - - - - -
find . -type f -print  -name "*.A.*.log" -exec sh -c "cat {} | grep 'seconds\|Running'" \; > result

for i in *; do
	if [[  -d "$i" ]] && [[ ! -e result_${i}.txt ]]; then
		find $i -type f -print  -name "*\.A\.*\.log" -exec sh -c "cat {} | grep 'seconds\|Running'" \; > result_${i}.txt
	fi
done
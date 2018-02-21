#!/bin/bash

# nohup bash -c "(time ./run_all.sh 0) 2>&1 | tee -a mountpoint/results/nohup_output.log" &

declare -a AZURE_MACHINES=( 1 2 3 4 9 55 )
# declare -a AZURE_MACHINES=( 2 3 4 5 10 56 )
declare -a NUMBER_INSTANCES=( 1 2 4 8 16 32 )

j=1

# set -x
for i in `seq ${#AZURE_MACHINES[@]} -1 1`; do
	for j in `seq 1 \` echo ${#AZURE_MACHINES[@]}-$i+1 | bc \``; do
		echo "AZURE_MACHINES: ${AZURE_MACHINES[$i]}"
		echo "NUMBER_INSTANCES: ${NUMBER_INSTANCES[$j]}"
		# ./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES[$i]} ${NUMBER_INSTANCES[$j]} 2>&1 | tee -a run_mpi_benchmark_v3_${i}_${j}.log &
		# sleep 13
	done
done




if [[ 0 ]]; then

rm /tmp/myCreateAzureMachine.lock

MINWAIT=1
MAXWAIT=10
# MAXWAIT=`echo "$MAXWAIT-$MINWAIT" | bc`


AZURE_MACHINES=55
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

AZURE_MACHINES=9
NUMBER_INSTANCES=2
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

AZURE_MACHINES=4
NUMBER_INSTANCES=4
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

AZURE_MACHINES=3
NUMBER_INSTANCES=8
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done


AZURE_MACHINES=9
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

AZURE_MACHINES=4
NUMBER_INSTANCES=2
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

# - - - - - - - - - - - - - - - - - - - - - - - - - - -

AZURE_MACHINES=3
NUMBER_INSTANCES=4
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

AZURE_MACHINES=2
NUMBER_INSTANCES=8
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

# wait

AZURE_MACHINES=4
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

AZURE_MACHINES=3
NUMBER_INSTANCES=2
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

# ------------------------


AZURE_MACHINES=2
NUMBER_INSTANCES=4
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

AZURE_MACHINES=1
NUMBER_INSTANCES=8
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done


AZURE_MACHINES=3
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

AZURE_MACHINES=2
NUMBER_INSTANCES=2
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

AZURE_MACHINES=1
NUMBER_INSTANCES=4
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done


AZURE_MACHINES=2
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

AZURE_MACHINES=1
NUMBER_INSTANCES=2
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done


AZURE_MACHINES=1
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

wait
# wait

stty -tostop

AZURE_MACHINES=1
NUMBER_INSTANCES=16
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

stty -tostop

AZURE_MACHINES=2
NUMBER_INSTANCES=16
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done

stty -tostop

AZURE_MACHINES=1
NUMBER_INSTANCES=32
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log
# read -p "Press enter to continue $AZURE_MACHINES , $NUMBER_INSTANCES"
for i in `seq 0 $NUMBER_INSTANCES` ; do sleep $(((RANDOM % $MAXWAIT)+$MINWAIT)); done


fi
#!/bin/bash

AZURE_MACHINES=55
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh senha pDyMoTChRGvm1/Pp0sz4USreLsttxoDa2xLKp/JXYWzppPUquesDLD7jerlLqdxSYGOGsLqRe8uYTLwtBW+AhQ== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a run_mpi_benchmark_v5_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &




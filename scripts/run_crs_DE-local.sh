#!/bin/bash

echo "Running CRS with DE and openMP locally"
#lscpu

CEPETRO="../../cepetro"
CEPETRO_CODES="../../cepetro/cepetro-codes"
sudo apt-get -y update
sudo apt-get -y install g++
#ls $CEPETRO_CODES
echo "HEY"
# g++ -std=c++11 $CEPETRO_CODES/src/main-openMP.cpp $CEPETRO_CODES/src/File.cpp $CEPETRO_CODES/src/SuFile.cpp $CEPETRO_CODES/src/DifferentialEvolution.cpp -o $CEPETRO_CODES/main-openMP -fopenmp -g -O3

# time $CEPETRO_CODES/main-openMP $CEPETRO/data/simple-syntetic-micro_sorted.su 1000 0.0 100 0.00015 70 10 10

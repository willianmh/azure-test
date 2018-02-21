#!/bin/bash

echo "Running CRS with DE and openMP locally"
#lscpu

CEPETRO_PATH="../../cepetro/cepetro-codes"
sudo apt update
sudo apt install g++

#ls $CEPETRO_PATH

g++ -std=c++11 $CEPETRO_PATH/src/main-openMP.cpp $CEPETRO_PATH/src/File.cpp $CEPETRO_PATH/src/SuFile.cpp $CEPETRO_PATH/src/DifferentialEvolution.cpp -o main-openMP -fopenmp -g -O3

time ./main-openMP ../data/simple-syntetic-micro_sorted.su 1000 0.0 100 0.00015 70 10 10

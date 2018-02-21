#!/bin/bash

echo "Running CMP with DE and openMP locally"
#lscpu

CEPETRO_PATH="../../cepetro/cepetro-codes"
sudo apt update
sudo apt install g++

#ls $CEPETRO_PATH

g++ -std=c++11 $CEPETRO_PATH/src/cmp-DE-openMP.cpp $CEPETRO_PATH/src/File.cpp $CEPETRO_PATH/src/SuFile.cpp $CEPETRO_PATH/src/DifferentialEvolution.cpp -o cmp-DE-openMP -fopenmp -g -O3

time ./cmp-DE-openMP ../data/simple-syntetic-micro_sorted.su 1000 0.0 100 0.00015 70 10 10

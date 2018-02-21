#!/bin/bash

echo "Running CRS by brute force with openMP locally"
#lscpu

CEPETRO_PATH="../../cepetro/cepetro-codes"
sudo apt update
sudo apt install g++

#ls $CEPETRO_PATH

g++ -std=c++11 $CEPETRO_PATH/src/crs-BF-openMP.cpp $CEPETRO_PATH/src/File.cpp $CEPETRO_PATH/src/SuFile.cpp $CEPETRO_PATH/src/DifferentialEvolution.cpp -o crs-BF-openMP -fopenmp -g -O3

time ./crs-BF-openMP ../data/simple-syntetic-micro_sorted.su 1000 0.0 100 0.00015 70 10 10

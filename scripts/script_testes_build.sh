#!/bin/bash

export ACC_DEVICE_TYPE=host
ROOT_DIR="/home/username/OpenCL-seismic-processing-tiago"


cd $ROOT_DIR/



#--------PROGRAM---------
PROGRAM=CMP

#CMP-CUDA
NAME=CUDA
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
make -j


#CMP-CUDAfp16
cd $ROOT_DIR/
NAME=CUDAfp16
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
make -j


#CMP-OpenACC - NOT
cd $ROOT_DIR/
NAME=OpenACC
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j


#CMP-CUDAfp16
cd $ROOT_DIR/
NAME=CUDAfp16
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
make -j


#CMP-OpenCL
cd $ROOT_DIR/
NAME=OpenCL
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j


#CMP-OpenMP
cd $ROOT_DIR/
NAME=OpenMP
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j

cd $ROOT_DIR/



#--------PROGRAM---------
PROGRAM=CRS

#CRS-CUDA
NAME=CUDA
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
make -j


#CRS-OpenACC - NOT
cd $ROOT_DIR/
NAME=OpenACC
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j


#CRS-OpenCL
cd $ROOT_DIR/
NAME=OpenCL
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j


#CRS-OpenMP
cd $ROOT_DIR/
NAME=OpenMP
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j

cd $ROOT_DIR/



#--------PROGRAM---------
PROGRAM=CRS-DE

#CRS-DE-OpenACC - NOT
NAME=OpenACC
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j


#CRS-OpenMP
cd $ROOT_DIR/
NAME=OpenMP
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j

cd $ROOT_DIR/


# #CRS-DE-OpenCL
# cd $ROOT_DIR/
# NAME=OpenCL
# cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
# if [ ! -d "bin" ]; then
#   mkdir bin
# fi
# cd bin/
# cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j
# cd $ROOT_DIR/

#!/bin/bash

SIZE=$1
 ./matrixMul_cuda/matrixMul -device=2 -wA=$SIZE -xB=$SIZE -hA=$SIZE -hB=$SIZE

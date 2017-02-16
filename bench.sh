#!/bin/bash
#SBATCH -o out
#SBATCH -e err
set -e

source ~/.bash_local
module load mkl
module load LEM_MODULE
module list

trap "touch done" EXIT

git clone github:cb-geo/lem-benchmarks

sed -i 's/"max_steps"\s*:\s*[0-9]*\s*,/"max_steps":20,/' lem-benchmarks/TESTCASE/lem.json

export CUDA_VISIBLE_DEVICES=1

/usr/bin/time -f 'time: %e' \
  lem -s SOLVER -d lem-benchmarks/TESTCASE/

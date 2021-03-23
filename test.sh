#! /bin/bash

for((i=1; i<=5;i++))
do
	for((j=1; j <= 9; j++))
	do
		python3 experiments/run/test.py /home/xiaoze/Desktop/PRODeep_CEGAR/nnet/ACASXU_run2a_${i}_${j}_batch_2000.nnet
	done
done

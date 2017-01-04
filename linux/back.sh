#!/bin/bash

if [ "$#" == 0 ];then
	cd ..
else
	NUMBER=$(echo $1 | grep -oE [0-9]+ | head -n 1)
	if [ -z $NUMBER ];then
		cd ..
	else
		for i in $(seq 1 $NUMBER);do
			cd ..
		done
	fi
fi

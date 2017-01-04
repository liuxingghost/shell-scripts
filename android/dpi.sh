#!/bin/bash

if [ $# != 2 ];then
	echo Syntax: width_x_height screen_inch
	exit 0
fi

width=${1%x*}
height=${1#*x}
echo "scale=4;sqrt($width^2+$height^2)/$2" | bc

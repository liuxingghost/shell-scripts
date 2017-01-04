#!/bin/bash

# This script is used for getting system size from all spreadtrum FWs in current directory

set -e
trap 'echo Error occured !; rm -rf $tmpdir' ERR

fwdir=$(pwd)
for i in `find $fwdir -name \*_Android_scatter.txt`;do
	size=$(grep -A 6 'partition_name: system' $i | grep -Eo 'partition_size:.*' | cut -d ' ' -f 2)
	echo $size $i
done

rm -rf $tmpdir

#!/bin/bash

# This script is used for getting system size from all spreadtrum FWs in current directory

EXTRACT_TOOL=/home/jujube/workspace/blender/Archos/bin/sprd-extractPac

tmpdir=$(mktemp -d)
fwdir=$(pwd)
pushd $tmpdir 1>/dev/null
for i in `find $fwdir -name \*.pac`;do
	rm -rf *
	$EXTRACT_TOOL $i 1>/dev/null
	xml=$(find -name \*.xml)
	size=$(xmlstarlet sel -t -v '/BMAConfig/ProductList/Product/Partitions/Partition[@id="system"]/@size' $xml)
	echo $size $i
done
popd 1>/dev/null

rm -rf $tmpdir

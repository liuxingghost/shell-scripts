#!/bin/bash

set -e

APKS="Books Chrome Drive EditorsDocs EditorsSheets EditorsSlides Gmail2 Hangouts Keep Maps Music2 Newsstand Photos PlayGames PlusOne Velvet Videos YouTube"
#UPDATE_ZIP=$1
APKTOOL='java -jar /home/jujube/workspace/blender/Archos/scripts/updateScript/lib/apktool_2.0.1.jar'
SYSTEM_IMG=$1
SIMG2IMG=/home/jujube/workspace/blender/Archos/scripts/updateScript/lib/simg2img

outdir=icons
mkdir $outdir
mkdir system
$SIMG2IMG $1 system_raw.img
sudo mount system_raw.img system
for i in $APKS;do
	#path=$(unzip -l $UPDATE_ZIP | grep ${i}.apk | head -n 1) # TODO take the case more than one apk are found
	path=$(find system -name ${i}.apk | head -n 1)
	if [ -z $path ];then
		continue
	fi
	#unzip $UPDATE_ZIP $path
	apk=$(basename $path)
	#mv $path .
	cp $path .
	#rm -r $(dirname $path)
	$APKTOOL d $apk || true

	cd $i
	icon=$(xmlstarlet sel -t -v '/manifest/application/@android:icon' AndroidManifest.xml | cut -d '/' -f 2)
	icon_file=$(find -name ${icon}\* | head -n 1)
	if [ -z $icon_file ];then
		cd ..
		rm -rf $i ${i}.apk
		continue
	fi
	ext=$(echo $icon_file | rev | cut -d '/' -f 1 | rev | cut -d '.' -f 2)
	cp $icon_file ../$outdir/${i}.${ext}
	cd ..
	rm -rf $i ${i}.apk
done
sudo umount system
rm -r system_raw.img system

chown -R jujube icons

#!/bin/bash

apks=$(adb shell pm list packages -f | grep '/data/app/' | sed -E 's/^package://' | sed -E 's/=.*$//')
for i in $apks;do
	package=$(echo $i | rev | cut -d '/' -f 2 | rev)
	adb pull $i ${package}.apk
done

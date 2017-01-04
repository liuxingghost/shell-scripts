#!/bin/bash

set -e

adb pull system/app/ app/
adb pull system/priv-app/ priv-app/
adb pull system/vendor/ vendor/

mkdir public_keys
for i in `find -name \*.apk`;do
	# extract public key
	tmpdir=$(mktemp -d)
	certfile="META-INF/CERT.RSA"
	if ! unzip $i $certfile -d $tmpdir;then
		unzip $i META-INF/TPKEY.RSA -d $tmpdir
		certfile="META-INF/TPKEY.RSA"
	fi
	filename=$(echo $i | sed -E 's#./(.*)#\1#g' | tr '/' '-')
	filepath=public_keys/$filename
	openssl pkcs7 -in $tmpdir/$certfile -print_certs -inform DER > $filepath

	# classify them
	if [ "$(find -name type\*)" ];then
		maxnum=$(find -regex './type[0-9]' | sort | tail -n 1 | grep -Eo '[0-9]+')
		match=no
		for j in `find -regex './type[0-9]'`;do
			if [ ! "$(diff $filepath $j)" ];then
				match=$(echo $j | grep -Eo 'type[0-9]+')
				break
			fi
		done
		if [ "$match" == "no" ];then
			maxnum=$((maxnum+1))
			cp $filepath type$maxnum
			echo $filename >> type${maxnum}.list
		else
			echo $filename >> ${match}.list
		fi
	else
		cp $filepath type1
		echo $filename >> type1.list
	fi
done

rm -r app priv-app verdor
#find -regex './type[0-9]+' -delete

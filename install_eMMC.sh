#!/bin/bash

fname=gpio-poweroff-cb1-eMMC

mkdir -p /boot/overlay-user
dtc -O dtb -o /boot/overlay-user/${fname}.dtbo ${fname}.dts

if grep -q '^user_overlays=' /boot/BoardEnv.txt; then
	line=$(grep '^user_overlays=' /boot/BoardEnv.txt | cut -d'=' -f2)
	if grep -qE "(^|[[:space:]])${fname}([[:space:]]|$)" <<< $line; then
		echo "Overlay ${fname} was already added to /boot/BoardEnv.txt, skipping"
	elif grep -q '^user_overlays=\s*$' /boot/BoardEnv.txt; then
		sed -i -e "s/^user_overlays=\s*$/user_overlays=${fname}/" /boot/BoardEnv.txt
	else
		sed -i -e "/^user_overlays=/ s/$/ ${fname}/" /boot/BoardEnv.txt
	fi
else
	sed -i -e "\$auser_overlays=${fname}" /boot/BoardEnv.txt
fi

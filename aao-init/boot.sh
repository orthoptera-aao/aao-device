#!/bin/bash

device="$(cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2)"

echo "[aao-device] Enabling networking..."
aao-pwr on wifi usb &> /dev/null

echo "[aao-device] Waiting for network..."
i="0"
while [ "$i" -lt 10 ];
	do
		ping aao.acousti.ca -c1 &> /dev/null
		if [ $? -eq  0 ]; then
			break
		fi
		((i++))
	done
if [ $i -eq 10 ]; then
	echo "[aao-device] Network connection could not be made!"
else
	echo "[aao-device] Attempting to download control file..."
	rm $device.json &> /dev/null
	wget http://aao.acousti.ca/devices/$device.json  &> /dev/null
	if [ $? -ne 0 ]; then
		echo "[aao-device] Failed to downlaod control file."
		echo "[aao-device] Using default control file."
		php init.php default.json
	else
		echo "[aao-device] Downloaded control file."
		echo "[aao-device] Using downloaded control file."
		php init.php $device.json
	fi
fi

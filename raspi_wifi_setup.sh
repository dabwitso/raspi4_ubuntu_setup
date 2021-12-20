#!/bin/bash
echo "This script sets up wifi connectivity.
Press [ENTER] to continue, [Ctrl + C] to quit"

read -t 2

CONFIG_FILE=/etc/netplan/50-cloud-init.yaml

while getopts ":s:p:h" opt;
do
	case ${opt} in
		h)
			echo "Usage: ./raspi_wifi_setup.sh [options...]"
			echo " -h  --help"
			echo " -s  --wifi_SSID"
			echo " -p  --wifi_password"
			exit 0
			;;
		s)
			SSID=${OPTARG};;
		p)
			PASSWORD=${OPTARG};;
		\?)
			echo "Invalid Option: -${OPTARG}" 1>&2
			./raspi_wifi_setup.sh -h
			exit 1
			;;
	esac
done


if [[ -z ${SSID} || -z ${PASSWORD} ]]
then
	echo "-s [SSID] or -p [PASSWORD] not passed as an argument. Check usage below:"
	./raspi_wifi_setup.sh -h
	exit 1
fi
sudo echo "  wifis:
    wlan0:
		  optional: true
			access-points:
			  ${SSID}:
				  password: ${PASSWORD}
			dhcp4: true" >> CONFIG_FILE

sudo netplan apply
ip a
echo "done
		To verify connectivity, run in terminal:
				ping 8.8.8.8

		Press Ctrl + C to terminate ping"


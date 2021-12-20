#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install ubuntu-desktop -y
sudo echo "network:
    ethernets:
		    eth0:
				    dhcp4: true
						optional: true
		version: 2" > /etc/netplan/50-cloud-init.yaml
read -t 10 -p "Installation completed\nPress [Enter] to reboot now, [Ctrl + C] to reboot later.\nWill automatically reboot after 10 secs if no action is taken by user."
sudo systemctl reboot

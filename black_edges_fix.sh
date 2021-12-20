#!/bin/bash

sudo echo "disable_overscan=1" >> /boot/firmware/config.txt
sudo systemctl reboot

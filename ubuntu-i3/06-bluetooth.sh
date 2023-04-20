#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

install_bluetooth(){
    echo "INSTALLING BLUETOOTH TOOLS"
    ADD bluez bluez-tools blueman
    echo "LOADING BLUETOOTH MODULE"
    sudo modprobe btusb > /dev/null
    echo "ENABLING BLUETOOTH SERVICE"
    sudo systemctl enable bluetooth > /dev/null
    sudo systemctl start bluetooth > /dev/null
}

install_bluetooth

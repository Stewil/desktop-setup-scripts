#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_bluetooth(){
    echo "INSTALLING BLUETOOTH TOOLS"
    ADD bluez bluez-utils blueman
    #YADD ttf-vlgothic
    echo "LOADING BLUETOOTH MODULE"
    sudo modprobe btusb
    echo "ENABLING BLUETOOTH SERVICE"
    sudo systemctl enable bluetooth
    sudo systemctl start bluetooth
}

install_bluetooth > /dev/null

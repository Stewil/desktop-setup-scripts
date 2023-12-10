#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_bluetooth(){
    ELOG "INSTALLING BLUETOOTH TOOLS"
    ADD bluez bluez-utils blueman
    #YADD ttf-vlgothic
    ELOG "LOADING BLUETOOTH MODULE"
    sudo modprobe btusb
    ELOG "ENABLING BLUETOOTH SERVICE"
    sudo systemctl enable bluetooth
    sudo systemctl start bluetooth
}

install_bluetooth > /dev/null

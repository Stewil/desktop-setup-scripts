#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

install_bluetooth(){
    ELOG "INSTALLING BLUETOOTH TOOLS"
    ADD bluez bluez-tools blueman
    ELOG "LOADING BLUETOOTH MODULE"
    sudo modprobe btusb
    ELOG "ENABLING BLUETOOTH SERVICE"
    sudo systemctl enable bluetooth
    sudo systemctl start bluetooth
}

install_bluetooth

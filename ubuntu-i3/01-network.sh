#!/bin/bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR="${ROOTDIR}/config/"


install_networking(){
    echo "INSTALLING NETWORK-MANAGER"
    sudo apt install -y network-manager avahi-daemon
}

install_networking

#!/usr/bin/env bash
ROOTDIR=$(readlink -f “${BASH_SOURCE:-$0}”)
source $ROOTDIR/arch-utils.sh

install_netman(){
    echo "INSTALL NETWORK MANAGER"
    ADD networkmanager
}

install_netman

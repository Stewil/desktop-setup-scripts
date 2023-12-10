#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_netman(){
    ELOG "INSTALL NETWORK MANAGER"
    ADD networkmanager
}

install_netman

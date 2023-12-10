#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

install_networking(){
    ELOG "INSTALLING NETWORK-MANAGER"
    ADD network-manager avahi-daemon
}

install_networking

#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
USERNAME="$(whoami)"
source $ROOTDIR/utils.sh

setup_ubuntu_server(){
    dir=$ROOTDIR/ubuntu-i3
    echo "ADDING FIREFOX APT PREFERENCES"
    sudo cp "${CFGDIR}/firefox-no-snap" /etc/apt/preferences.d/
    cd $dir
    source 00-prep.sh
    source 01-network.sh
    source 02-ui.sh
    source 03-audio.sh
    source 04-software.sh
}

setup_arch(){
    dir=$ROOTDIR/arch-i3
    cd dir
    source 00-prep.sh
    source 01-network.sh
    source 02-ui.sh
    source 03-audio.sh
    source 04-software.sh
    source 05-japanese.sh
}

setup(){
    DIST=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
    case $DIST in
        "ubuntu") setup_ubuntu_server ;;
        "arch") setup_arch ;;
        *) echo "No setup found for ${DIST}";;
    esac
}

setup

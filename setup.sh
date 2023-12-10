#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR=$ROOTDIR/config
USERNAME="$(whoami)"

setup_ubuntu_server(){
    export DEBIAN_FRONTEND=noninteractive
    dir=$ROOTDIR/ubuntu-i3
    echo "ADDING FIREFOX APT PREFERENCES"
    sudo cp "${CFGDIR}/firefox-no-snap" /etc/apt/preferences.d/
    cd $dir
    ./00-prep.sh
    ./01-network.sh
    ./02-ui.sh
    ./03-audio.sh
    ./04-software.sh
    ./05-locale.sh
    ./06-bluetooth.sh
    cd -
}

setup_arch(){
    dir=$ROOTDIR/arch-i3
    cd $dir
    ./00-prep.sh
    ./01-network.sh
    ./02-ui.sh
    ./03-audio.sh
    ./04-software.sh
    ./05-language.sh
    ./06-bluetooth.sh
    cd -
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
$ROOTDIR/config-user.sh

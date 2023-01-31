#!/bin/bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR="${ROOTDIR}/config/"

install_audio(){
    echo "INSTALLING ALSA"
    sudo apt install -y libasound2 libasound2-plugins alsa-utils alsa-oss
    echo "INSTALLING PULSE"
    sudo apt install -y pulseaudio pulseaudio-utils
    echo "INSTALLING PAVUCONTROL"
    sudo apt install -y pavucontrol
}

install_audio

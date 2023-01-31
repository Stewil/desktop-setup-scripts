#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

install_audio(){
    echo "INSTALLING ALSA"
    ADD libasound2 libasound2-plugins alsa-utils alsa-oss
    echo "INSTALLING PULSE"
    ADD pulseaudio pulseaudio-utils
    echo "INSTALLING PAVUCONTROL"
    ADD pavucontrol
}

install_audio

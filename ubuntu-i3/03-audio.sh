#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

install_audio(){
    ELOG "INSTALLING ALSA"
    ADD libasound2 libasound2-plugins alsa-utils alsa-oss
    ELOG "INSTALLING PULSE"
    ADD pulseaudio pulseaudio-utils
    ELOG "INSTALLING PAVUCONTROL"
    ADD pavucontrol
}

install_audio

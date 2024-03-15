#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_audio(){
    ELOG "INSTALLING AUDIO"
    ADD alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pavucontrol
}

install_audio

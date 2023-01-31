#!/usr/bin/env bash
source $ROOTDIR/arch-utils.sh

install_audio(){
    echo "INSTALLING AUDIO"
    ADD alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pavucontrol
}

install_audio

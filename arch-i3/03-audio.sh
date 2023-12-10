#!/usr/bin/env bash
source $ROOTDIR/arch-utils.sh

install_audio(){
    ELOG "INSTALLING AUDIO"
    ADD alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pavucontrol
}

install_audio

#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source "$ROOTDIR/arch-utils.sh"

install_audio(){
    ELOG "INSTALLING AUDIO"
    ADD pipewire-audio pipewire-alsa pipewire pipewire-pulse pavucontrol wireplumber
}

install_audio

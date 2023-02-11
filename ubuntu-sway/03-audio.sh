#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

install_audio(){
    echo "INSTALLING PIPEWIRE"
    ADD pipewire pipewire-audio-client-libraries libspa-0.2-bluetooth libspa-0.2-jack 
}

install_audio

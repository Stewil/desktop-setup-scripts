#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_japanese(){
    echo "INSTALLING JAPANESE LANGUAGE TOOLS"
    ADD fcitx-im fcitx-configtool fcitx-mozc
    #YADD ttf-vlgothic
}

install_japanese

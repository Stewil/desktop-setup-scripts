#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_lang(){
    ELOG "INSTALLING LANGUAGE INPUT TOOLS"
    ADD fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-mozc fcitx5-qt
    #YADD ttf-vlgothic
}

install_lang

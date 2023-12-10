#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

setup_locale(){
    echo "SETTING UP LOCALES"
    ADD language-pack-en
    locale-gen
}

setup_input(){
    echo "SETTING UP INPUT"
    ADD fcitx5 fcitx5-config-qt fcitx5-frontend-gtk2 fcitx5-frontend-gtk3 fcitx5-frontend-qt5 fcitx5-mozc
}

setup_locale
setup_input

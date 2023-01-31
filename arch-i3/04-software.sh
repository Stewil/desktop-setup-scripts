#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_software(){
    echo "INSTALLING COMMONLY USED SOFTWARE"
    ADD rxvt-unicode curl wget neofetch neovim unrar zip unzip htop clang cmake gcc glibc gimp
    YADD neovim-plug
}

install_software

#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

install_software(){
    ELOG "INSTALLING COMMONLY USED SOFTWARE"
    ADD neofetch zip unzip unrar tar 7zip gzip clang bash-completion rxvt-unicode file python3-neovim openssh-client imagemagick
}

install_software

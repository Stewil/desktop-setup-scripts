#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_software(){
    echo "INSTALLING COMMONLY USED SOFTWARE"
    ADD rxvt-unicode curl wget neofetch neovim unrar zip unzip htop clang cmake gcc glibc gimp bash-completion xclip imagemagick mpv fuse2 keepassxc libwebp imlib2
}

install_software

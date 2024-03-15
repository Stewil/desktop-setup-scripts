#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_software(){
    ELOG "INSTALLING COMMONLY USED SOFTWARE"
    ADD rxvt-unicode curl wget neofetch neovim unrar zip unzip htop clang cmake gcc glibc gimp bash-completion xclip imagemagick mpv fuse2 keepassxc libwebp imlib2 sysstat python-neovim python-pynvim openssh tree-sitter mousepad
}

install_software

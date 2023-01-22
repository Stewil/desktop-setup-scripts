#!/bin/bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR="${ROOTDIR}/config/"

install_software(){
    sudo apt install -y neofetch zip unzip unrar tar 7zip gzip clang bash-completion rxvt-unicode
}

install_software

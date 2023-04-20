#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR="${ROOTDIR}/config/"

ADD(){
    sudo pacman -Sy --noconfirm --needed "$@" > /dev/null
}

YADD(){
	yay -Sy --noconfirm --needed "$@" > /dev/null
}

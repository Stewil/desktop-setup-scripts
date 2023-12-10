#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source "$ROOTDIR/../script-utils.sh"

ADD(){
    sudo pacman -Sy --noconfirm --needed "$@" > /dev/null
}

YADD(){
	yay -Sy --noconfirm --needed "$@" > /dev/null
}

#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR="${ROOTDIR}/config/"

ADD(){
    sudo pacman -Sy --noconfirm --needed "$@"
}

YADD(){
	yay -Sy --noconfirm --needed "$@"
}

EXISTS(){
    # call as:
    # EXISTS line='thisline' file='/home/file.txt'
    local "${@}"
    if [ -z ${file+x} ]; then 
        echo "file to check was not given" && return -1
    fi
    if [ -z ${line+x} ]; then 
        echo "line to check was not given" && return -1
    fi
    return grep -Fxq "$line" "$file"
}


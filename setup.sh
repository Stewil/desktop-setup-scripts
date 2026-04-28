#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR="$ROOTDIR/config"
USERNAME="$(whoami)"
source "$ROOTDIR/script-utils.sh"

setup_arch(){
    dir=$ROOTDIR/arch-i3
    cd "$dir" || (ELOG "Can't find arch setup dir at $dir"; exit)
    ./00-prep.sh
    ./01-network.sh
    ./02-ui.sh
    ./03-audio.sh
    ./04-software.sh
    ./05-language.sh
    ./06-bluetooth.sh
    ./99-arch-config.sh
    cd - || exit
}

setup(){
    DIST=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
    case $DIST in
        "arch") setup_arch ;;
        *) ELOG "No setup found for ${DIST}";;
    esac
}

setup > /dev/null
"$ROOTDIR/config-user.sh"

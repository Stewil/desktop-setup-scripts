#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

setup_locale(){
    echo "SETTING UP LOCALES"
    ADD language-pack-en
    locale-gen
    localectl set-x11-keymap us
}

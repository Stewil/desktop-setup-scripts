#!/usr/bin/env bash
ROOTDIR=$(dirname "$(realpath "$0")")
source "$ROOTDIR/arch-utils.sh"

pkgfile_conf() {
    local CONFLINE='source /usr/share/doc/pkgfile/command-not-found.bash'
    if ! grep -qxF "$CONFLINE"; then
        echo "$CONFLINE" >> "$HOME/.bashrc"
    fi
}

pkgfile_conf

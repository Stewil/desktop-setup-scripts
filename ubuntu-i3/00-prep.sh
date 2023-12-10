#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

install_base_deps(){
    ELOG "INSTALLING BASE DEPENDENCIES"
    ADD apt-utils
    ADD software-properties-common gnupg gpg-agent
    ADD build-essential cmake git wget curl
}

remove_auto_update(){
    ELOG "REMOVING UNATTENDED UPGRADES"
    sudo apt-get autoremove --purge -y unattended-upgrades
}

remove_snap(){
    if [[ $(dpkg -s snapd 2> /dev/null ) ]] ; then
    ELOG "DISABLING SNAP SERVICE"
    sudo systemctl disable snapd.service
    sudo systemctl disable snapd.socker
    sudo systemctl disable snapd.seeded.service
    ELOG "REMOVING ALL SNAP PACKAGES"
    while [[ $(sudo snap list | tail -n +2) ]]; do
        snaps=$(sudo snap list |tail -n +2 | awk '{print $1}')
        for i in $snaps; do
            sudo snap remove "$i" || ELOG "Error removing $i"
        done
    done
    ELOG "REMOVING SNAP"
    sudo apt-get autoremove --purge -y snapd
    sudo rm -rf /var/cache/snapd/
    rm -rf ~/snap
    sudo systemctl daemon-reload
    fi
}

add_firefox_ppa(){
    ELOG "ADDING PPA"
    sudo add-apt-repository -y ppa:mozillateam/ppa
}

install_base_deps
remove_auto_update
remove_snap
add_firefox_ppa

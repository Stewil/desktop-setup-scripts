#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

remove_snap(){
    echo "DISABLING SNAP SERVICE"
    sudo systemctl disable snapd.service
    sudo systemctl disable snapd.socker
    sudo systemctl disable snapd.seeded.service
    echo "REMOVING ALL SNAP PACKAGES"
    while [[ $(sudo snap list | tail -n +2) ]]; do
        snaps=$(sudo snap list |tail -n +2 | awk '{print $1}')
        for i in $snaps; do
            sudo snap remove "$i" || echo "Error removing $i"
        done
    done
    echo "REMOVING SNAP"
    sudo apt autoremove --purge -y snapd
    sudo rm -rf /var/cache/snapd/
    rm -rf ~/snap
}

add_firefox_ppa(){
    echo "ADDING PPA"
    sudo add-apt-repository -y ppa:mozillateam/ppa
}

install_base_deps(){
    echo "INSTALLING BASE DEPENDENCIES"
    ADD build-essential cmake git wget curl 
}

remove_snap
add_firefox_ppa
install_base_deps

#!/usr/bin/env bash
ROOTDIR=$(cd $(dirname “${BASH_SOURCE:-$0}”) && pwd)
echo "ROOT: $ROOTDIR"
source $ROOTDIR/arch-utils.sh

install_base(){
    echo "INSTALL BASE"
    ## needed for yay setup
    ADD base-devel go
}

setup_yay() {
    echo "SETUP YAY"
	cd /opt
	sudo git clone https://aur.archlinux.org/yay.git
	sudo chown -R $USER:$USER ./yay
	cd - && cd /opt/yay 
	makepkg -si --noconfirm
	cd -
}

install_base
setup_yay

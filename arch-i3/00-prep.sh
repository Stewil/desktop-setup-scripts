#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_base(){
    ELOG "INSTALL BASE"
    ## needed for yay setup
    ADD base-devel go
}

setup_yay() {
    ELOG "SETUP YAY"
	cd /opt
	sudo git clone https://aur.archlinux.org/yay.git
	sudo chown -R $USER:$USER ./yay
	cd - && cd /opt/yay 
	makepkg -si --noconfirm
	cd -
}

install_base
setup_yay

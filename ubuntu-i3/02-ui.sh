#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

install_wm(){
    echo "INSTALLING WINDOW MANAGER"
    ADD i3-wm picom i3blocks i3lock i3status dunst rofi nitrogen arandr xinit scrot
    ADD python-is-python3 python3-pip
    ADD libxcb-render0-dev libffi-dev python3-dev python3-cffi
    python3 -m pip install flashfocus
}

install_tools(){
    echo "INSTALLING VARIOUS TOOLS"
    ADD policykit-1-gnome thunar flameshot feh x11-xkb-utils
    echo "INSTALLING FONTS"
    ADD fonts-noto* fonts-font-awesome
}

install_applications(){
    echo "INSTALLING APPLICATIONS"
    ADD firefox 
    wget -P /tmp https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && sudo apt install -y /tmp/nvim-linux64.deb

}

install_wm
install_tools
install_applications

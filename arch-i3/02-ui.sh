#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_wm(){
    echo "INSTALLING WINDOW MANAGER"
    ADD picom i3-wm i3status i3blocks i3lock xorg-init 
    YADD flashfocus-git
}

install_tools(){
    echo "INSTALLING VARIOUS TOOLS"
    ADD polkit-gnome arandr nitrogen dunst rofi
    echo "INSTALLING FONTS"
    ADD noto-fonts-cjk noto-fonts-emoji noto-fonts
    YADD ttf-font-awesome
}

install_applications() {
    echo "INSTALLING APPLICATIONS"
    ADD thunar flameshot feh
}

install_wm
install_tools
install_applications
conf_xinit
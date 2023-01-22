#!/bin/bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR="${ROOTDIR}/config/"

install_wm(){
    echo "INSTALLING WINDOW MANAGER"
    sudo apt install -y i3-wm picom i3blocks i3status dunst rofi nitrogen arandr xinit scrot
    sudo apt install python-is-python3 python3-pip
    sudo apt install -y libxcb-render0-dev libffi-dev python3-dev python3-cffi
    python3 -m pip install flashfocus
}

install_tools(){
    echo "INSTALLING VARIOUS TOOLS"
    sudo apt install -y systemsettings polkit-kde-agent-1 dolphin flameshot feh
    echo "INSTALLING FONTS"
    sudo apt install -y fonts-noto* fonts-font-awesome
    echo "INSTALLING THEMES"
    sudo apt install -y breeze*
}

install_applications(){
    echo "INSTALLING APPLICATIONS"
    sudo apt install -y firefox 
    wget -P /tmp https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && sudo apt install -y /tmp/nvim-linux64.deb

}

conf_xinit(){
    cp "$CFGDIR"/xinitrc ~/.xinitrc
    cp "$CFGDIR"/bash_login ~/.bash_login
}

install_wm
install_tools
install_applications
conf_xinit

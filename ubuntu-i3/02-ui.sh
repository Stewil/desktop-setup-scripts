#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

install_wm(){
    echo "INSTALLING WINDOW MANAGER"
    ADD xorg i3-wm picom i3blocks i3lock i3status dunst rofi nitrogen arandr xinit scrot lightdm lightdm-gtk-greeter gnome-themes-extra
    ADD python-is-python3 python3-pip
    ADD libxcb-render0-dev libffi-dev python3-dev python3-cffi
    ADD dbus-x11 at-spi2-core
    python3 -m pip install flashfocus
    sudo dpkg-reconfigure lightdm
}

install_tools(){
    echo "INSTALLING VARIOUS TOOLS"
    ADD policykit-1-gnome thunar flameshot sxiv x11-xkb-utils mpv
    echo "INSTALLING FONTS"
    ADD fonts-noto* 
    if [ ! -f "$HOME/.local/share/fonts/DejaVu Sans Mono for Powerline.ttf" ]; then
    mkdir -p /home/$USER/.local/share/fonts
        git clone https://github.com/powerline/fonts.git --depth=1 /tmp/fonts \
            && cd /tmp/fonts && ./install.sh && cd -
    fi
    if [ ! -f "$HOME/.local/share/fonts/Font Awesome 6 Free-Regular-400.otf" ]; then
        git clone https://github.com/FortAwesome/Font-Awesome /tmp/fa && \
            cp /tmp/fa/otfs/* /home/$USER/.local/share/fonts/
    fi
    fc-cache -f -v
}

install_applications(){
    echo "INSTALLING APPLICATIONS"
    ADD firefox
    if [ ! -f /usr/bin/nvim ]; then
        wget -P /tmp https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb \
            && sudo apt install -y /tmp/nvim-linux64.deb
    fi
}

install_wm
install_tools
install_applications

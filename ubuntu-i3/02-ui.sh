#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

install_drivers(){
    echo 'INSTALLING DRIVERS'
    sudo ubuntu-drivers autoinstall
}

install_wm(){
    echo "INSTALLING WINDOW MANAGER"
    ADD xorg i3-wm picom i3blocks i3lock i3status dunst rofi nitrogen arandr xinit scrot lightdm lightdm-gtk-greeter gnome-themes-extra
    ADD python-is-python3 python3-pip
    ADD libxcb-render0-dev libffi-dev python3-dev python3-cffi
    ADD dbus-x11 at-spi2-core
    sudo python3 -m pip install flashfocus
    sudo dpkg-reconfigure lightdm
}

install_tools(){
    echo "INSTALLING VARIOUS TOOLS"
    ADD policykit-1-gnome thunar flameshot x11-xkb-utils mpv powerline libimlib2-dev libxft-dev libexif-dev
    echo "INSTALLING FONTS"
    ADD fonts-noto*
    if [ ! -f "$HOME/.local/share/fonts/DejaVu Sans Mono for Powerline.ttf" ]; then
    mkdir -p $HOME/.local/share/fonts
        sudo bash -c "git clone https://github.com/powerline/fonts.git \
            --depth=1 /tmp/fonts && cd /tmp/fonts && ./install.sh"
    fi
    if [ ! -f "$HOME/.local/share/fonts/Font Awesome 6 Free-Regular-400.otf" ]; then
        git clone https://github.com/FortAwesome/Font-Awesome /tmp/fa && \
            cp /tmp/fa/otfs/* "$HOME/.local/share/fonts/"
    fi
    if [ ! -f /usr/local/bin/nsxiv ]; then
        echo "BUILDING AND INSTALLING NSXIV"
        sudo bash -c "git clone https://codeberg.org/nsxiv/nsxiv /tmp/nsxiv  && \
            cd /tmp/nsxiv && make && make install"
    fi
    fc-cache -f -v 
}

install_applications(){
    echo "INSTALLING APPLICATIONS" 
    ADD firefox
    if [ ! -f /usr/bin/nvim ]; then
        wget -q -P /tmp https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
        sudo bash -c "cd /tmp && tar -xf nvim-linux64.tar.gz && cp -r nvim-linux64/* /usr/local/ || echo 'INSTALLING NEOVIM FAILED'"
    fi
}

install_drivers > /dev/null
install_wm > /dev/null
install_tools > /dev/null
install_applications > /dev/null

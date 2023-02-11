#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/ubuntu-utils.sh

install_desktop(){
    echo "INSTALLING DESKTOP"
    ADD libwayland-bin libwayland-client0 libwayland-cursor0 libwayland-egl1 libwayland-server0 seatd sway foot gdm3 policykit-1-gnome dunst rofi dmenu scrot sway-backgrounds swaybg swayidle swayimg swaylock nemo flameshot wlr-randr wlogout mpv firefox 
    ADD python-is-python3 python3-pip
    wget -P /tmp https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && sudo apt install -y /tmp/nvim-linux64.deb
    echo "INSTALLING FONTS"
    ADD fonts-noto* fontconfig
    mkdir -p /home/$USER/.local/share/fonts
    git clone https://github.com/powerline/fonts.git --depth=1 /tmp/fonts && cd /tmp/fonts && ./install.sh && cd -
    git clone https://github.com/FortAwesome/Font-Awesome /tmp/fa && cp /tmp/fa/otfs/* /home/$USER/.local/share/fonts/
    fc-cache -f -v
}

install_desktop

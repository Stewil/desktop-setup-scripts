#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_wm(){
    echo "INSTALLING WINDOW MANAGER"
    ADD picom i3-wm i3status i3blocks i3lock xorg-xinit lightdm lightdm-gtk-greeter gnome-themes-extra
    ADD dbus at-spi2-core
    YADD flashfocus-git
}

install_tools(){
    echo "INSTALLING VARIOUS TOOLS"
    ADD polkit-gnome arandr nitrogen dunst rofi powerline powerline-fonts firefox acpi
    echo "INSTALLING FONTS"
    ADD noto-fonts-cjk noto-fonts-emoji noto-fonts
    YADD ttf-font-awesome
    if [ ! -f "$HOME/.local/share/fonts/DejaVu Sans Mono for Powerline.ttf" ]; then
    mkdir -p "$HOME/.local/share/fonts"
        sudo bash -c "git clone https://github.com/powerline/fonts.git \
            --depth=1 /tmp/fonts && cd /tmp/fonts && ./install.sh"
    fi
    fc-cache -f -v
}

install_applications() {
    echo "INSTALLING APPLICATIONS"
    ADD thunar flameshot thunar-volman gvfs gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs imlib2
    if [ ! -f /usr/local/bin/nsxiv ]; then
        sudo bash -c "git clone https://codeberg.org/nsxiv/nsxiv /tmp/nsxiv && \
            cd /tmp/nsxiv && make && make install"
    fi
}

install_wm
install_tools
install_applications

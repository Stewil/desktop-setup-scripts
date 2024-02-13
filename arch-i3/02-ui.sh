#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source $ROOTDIR/arch-utils.sh

install_wm(){
    ELOG "INSTALLING WINDOW MANAGER"
    ADD picom i3-wm i3status polybar i3lock xorg-xinit lightdm lightdm-gtk-greeter gnome-themes-extra scrot
    ADD dbus at-spi2-core xf86-input-libinput
    YADD flashfocus-git
}

install_tools(){
    ELOG "INSTALLING VARIOUS TOOLS"
    ADD polkit-gnome arandr nitrogen dunst rofi powerline powerline-fonts firefox acpi xorg-mkfontscale xorg-fonts-100dpi xorg-fonts-75dpi xorg-fonts-misc xorg-font-util
    ELOG "INSTALLING FONTS"
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
    ELOG "INSTALLING APPLICATIONS"
    ADD thunar flameshot thunar-volman gvfs gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs imlib2 network-manager-applet
    if [ ! -f /usr/local/bin/nsxiv ]; then
        sudo bash -c "git clone https://codeberg.org/nsxiv/nsxiv /tmp/nsxiv && \
            cd /tmp/nsxiv && make && make install"
    fi
}

install_wm
install_tools
install_applications

#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source "$ROOTDIR/arch-utils.sh"

install_wm(){
    ELOG "INSTALLING WINDOW MANAGER"
    ADD picom i3-wm i3status polybar i3lock xorg-xinit lightdm lightdm-gtk-greeter gnome-themes-extra
    ADD dbus at-spi2-core xf86-input-libinput
    YADD flashfocus-git
}

install_tools(){
    ELOG "INSTALLING VARIOUS TOOLS"
    ADD polkit-gnome arandr nitrogen dunst rofi firefox acpi xorg-mkfontscale xorg-fonts-100dpi xorg-fonts-75dpi xorg-fonts-misc xorg-font-util
    ELOG "INSTALLING FONTS"
    ADD noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-hack-nerd woff2-font-awesome
    YADD liquidprompt
    fc-cache -f -v
}

install_applications() {
    ELOG "INSTALLING APPLICATIONS"
    ADD xfce4-screenshooter ristretto thunar thunar-volman \
        gvfs gvfs-gphoto2 gvfs-mtp gvfs-nfs \
        imlib2 network-manager-applet rxvt-unicode mpv xclip \
        mousepad 
}

install_wm
install_tools
install_applications

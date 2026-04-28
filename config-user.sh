#!/usr/bin/env bash
# thanks to https://www.pixiv.net/en/users/21549100 for the lovely bg illustration
# thanks to https://www.pixiv.net/en/users/3069527 for the lovely greeter illustration
REALPATH="$(realpath "$0")"
ROOTDIR="$(dirname "$REALPATH")"
CFGDIR=$ROOTDIR/config
DIST=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
source "$ROOTDIR/script-utils.sh"

config_i3(){
    ELOG "CONFIGURING I3"
    mkdir -p ~/.config/i3
    cp -r "$CFGDIR"/i3/* ~/.config/i3/
}

config_rofi(){
    ELOG "CONFIGURING ROFI"
    cp -r "$CFGDIR"/rofi ~/.config/
}

config_picom(){
    ELOG "CONFIGURING PICOM"
    cp -r "$CFGDIR"/picom ~/.config/
}

config_tab_completion(){
    ELOG "CONFIGURING TAB COMPLETION"
    # shellcheck disable=SC2016
    if [ ! -e ~/.inputrc ]; then
        echo '$include /etc/inputrc' > ~/.inputrc
        echo 'set completion-ignore-case On' >> ~/.inputrc
        echo 'set colored-stats on' >> ~/.inputrc
    fi
}

config_neovim(){
    ELOG "CONFIGURING NEOVIM"
    cp "$CFGDIR"/clang-format ~/.clang-format
    NVIM_BIN="$(which nvim)"
    if [ "$DIST" != "ubuntu" ]; then
        sudo ln -s "$NVIM_BIN" /usr/bin/editor
        sudo ln -s "$NVIM_BIN" /usr/bin/edit
        sudo ln -s "$NVIM_BIN" /usr/bin/vi
        sudo ln -s "$NVIM_BIN" /usr/bin/vim
    fi
    nvim --clean +qall
    nvim "+TSInstall cpp python" +qall
}

config_aliases(){
    ELOG "CONFIGURING ALIASES"
    cp -r "$CFGDIR"/aliases ~/.aliases
    cp -r "$CFGDIR"/bashrc ~/.bashrc
}

config_themes(){
    ELOG "CONFIGURING THEMES"
    cp "$CFGDIR"/Xresources ~/.Xresources
}

config_lightdm(){
    if [ "$DIST" != "ubuntu" ]; then
        ELOG "CONFIGURING LIGHTDM"
        sudo cp "$CFGDIR"/lightdm.conf /etc/lightdm/lightdm.conf
        sudo systemctl enable lightdm
    fi
}

config_pcspkr(){
    ELOG "CONFIGURING PCSPKR"
    sudo cp "$CFGDIR"/nobeep.conf /etc/modprobe.d/nobeep.conf

}

config_defaults(){
    ELOG "CONFIGURING DEFAULT APPLICATIONS"
    xdg-mime default thunar.desktop inode/directory
    xdg-mime default ristretto.desktop image/bmp image/gif image/jpeg image/jpg \
        image/png image/tiff image/x-bmp image/x-portable-anymap \
        image/x-portable-bitmap image/x-portable-greymap image/x-tga \
        image/x-xpixmap image/webp
    sudo cp "$CFGDIR/nsxiv.desktop /usr/share/applications/nsxiv.desktop"
    xdg-mime default firefox.desktop text/markdown text/html application/pdf \
        x-scheme-handler/http x-scheme-handler/https x-scheme-handler/unknown
    xdg-mime default mpv.desktop video/mpeg video/x-mpeg2 video/x-mpeg3 \
        video/x-m4v video/ogg video/quicktime video/flv video/x-flv \
        video/x-matroska video/mkv video/webm video/3gp video/3gpp video/mp4
    xdg-settings set default-web-browser firefox.desktop
}

config_wallpaper(){
    ELOG "CONFIGURING WALLPAPER"
    if [ ! -f ~/Pictures/wp/bg.jpg ]; then
    mkdir -p ~/Pictures/wp
    wget -O ~/Pictures/wp/bg.jpg \
        --referer='https://www.pixiv.net/en/artworks/85281138' \
        https://i.pximg.net/img-original/img/2020/10/27/23/47/17/85281138_p0.jpg -q --show-progress
    mkdir -p ~/.config/nitrogen
    sudo tee ~/.config/nitrogen/bg-saved.cfg <<EOF
[xin_-1]
file=$HOME/Pictures/wp/bg.jpg
mode=4
bgcolor=#000000
EOF
    fi
}

config_greeter(){
    ELOG "CONFIGURING GREETER"
    if [ ! -f /usr/share/pixmaps/greeter.jpg ]; then
        sudo mkdir -p /usr/share/pixmaps
        sudo wget -O /usr/share/pixmaps/greeter.jpg \
            --referer='https://www.pixiv.net/en/artworks/91390457' \
            https://i.pximg.net/img-original/img/2021/07/21/11/40/10/91390457_p0.jpg -q --show-progress
        if  ! grep -q greeter.jpg /etc/lightdm/lightdm-gtk-greeter.conf; then
            sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf <<EOF
position = 15%,center 70%,center
background = /usr/share/pixmaps/greeter.jpg
user-background = true
theme-name = Adwaita-dark
EOF
        fi
    fi
}

config_profile(){
    ELOG 'CONFIGURING PROFILE'
    cp "$CFGDIR"/profile ~/.profile
    cp "$CFGDIR"/xprofile ~/.xprofile
}

config_ssh-agent(){
    ELOG 'CONFIGURING SSH_AGENT'
    systemctl --user enable ssh-agent
}

config_xfce4(){
    ELOG 'CONFIGURING XFCE4'
    cp -r "$CFGDIR"/xfce4 ~/.config/
}

configure_user(){
    if [[ $EUID -gt 0 ]]; then #not root
        config_i3
        config_rofi
        config_picom
        config_tab_completion
        config_aliases
        config_neovim
        config_themes
        config_pcspkr
        config_lightdm
        config_wallpaper
        config_greeter
        config_profile
        config_ssh-agent
        config_fcitx
        config_xfce4
    else
        ELOG "It does not really make sense to configure the user, running as root."
        ELOG "Does it?"
    fi
}

configure_user > /dev/null

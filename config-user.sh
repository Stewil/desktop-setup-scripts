#!/usr/bin/env bash
# thanks to https://www.pixiv.net/en/users/21549100 for the lovely bg illustration
# thanks to https://www.pixiv.net/en/users/3069527 for the lovely greeter illustration
ROOTDIR=$(dirname $(realpath "$0"))
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

config_powerline(){
    ELOG "CONFIGURING POWERLINE"
    cp -r "$CFGDIR"/powerline ~/.config/
}

config_tab_completion(){
    ELOG "CONFIGURING TAB COMPLETION"
    if [ ! -a ~/.inputrc ]; then
        echo '$include /etc/inputrc' > ~/.inputrc
        echo 'set completion-ignore-case On' >> ~/.inputrc
    fi
}

config_neovim(){
    ELOG "CONFIGURING NEOVIM"
    if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
        curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    cp -r "$CFGDIR"/nvim ~/.config/
    cp "$CFGDIR"/clang-format ~/.clang-format
    NVIM_BIN="$(which nvim)"
    if [ "$DIST" != "ubuntu" ]; then
        sudo ln -s "$NVIM_BIN" /usr/bin/editor
        sudo ln -s "$NVIM_BIN" /usr/bin/edit
        sudo ln -s "$NVIM_BIN" /usr/bin/vi
        sudo ln -s "$NVIM_BIN" /usr/bin/vim
    else
        sudo update-alternatives --install /usr/bin/editor  editor  "$NVIM_BIN" 100
        sudo update-alternatives --install /usr/bin/edit    edit    "$NVIM_BIN" 100
        sudo update-alternatives --install /usr/bin/vi      vi      "$NVIM_BIN" 100
        sudo update-alternatives --install /usr/bin/vim     vim     "$NVIM_BIN" 100
        sudo update-alternatives --set editor   "$NVIM_BIN"
        sudo update-alternatives --set edit     "$NVIM_BIN"
        sudo update-alternatives --set vi       "$NVIM_BIN"
        sudo update-alternatives --set vim      "$NVIM_BIN"
    fi
    nvim --clean +qall
    nvim +PlugUpdate +UpdateRemotePlugins "+TSInstall cpp python" +qall
}

config_nerdfont(){
    ELOG "CONFIGURING NERDFONTS"
    NFDIR="/usr/share/fonts/truetype/nerdfonts"
    if [ ! -d "$NFDIR" ]; then
        sudo mkdir -p "$NFDIR"
    fi
    if [ ! -f "$NFDIR/Hack Regular Nerd Font Complete.ttf" ]; then
        ELOG "INSTALLING NERDFONT: HACK"
        wget -O /tmp/hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip -q --show-progress
        sudo bash -c "cd /tmp && unzip hack.zip && cp Hack* $NFDIR/ || ELOG 'ERROR INSTALLING NF HACK'"
    fi
    sudo fc-cache -f -v
}

config_aliases(){
    ELOG "CONFIGURING ALIASES"
    cp -r "$CFGDIR"/aliases ~/.aliases
    cp -r "$CFGDIR"/bashrc ~/.bashrc
}

config_themes(){
    ELOG "CONFIGURING THEMES"
    cp "$CFGDIR"/Xresources ~/.Xresources
    mkdir -p ~/.themes
    if [ ! -d ~/.themes/Nordic ]; then
        git clone https://github.com/EliverLara/Nordic.git ~/.themes/Nordic
    fi
    if [ ! -d ~/.themes/firefox-nordic-theme ]; then
        git clone https://github.com/EliverLara/firefox-nordic-theme ~/.themes/firefox-nordic-theme/ && ~/.themes/firefox-nordic-theme/scripts/install.sh 
    fi
    if [ ! -d ~/.local/share/icons/Zafiro-Icons-Dark/ ]; then
        wget -N https://raw.githubusercontent.com/zayronxio/Zafiro-icons/master/Install-Zafiro-Icons.sh -q --show-progress  && chmod +x Install-Zafiro-Icons.sh && bash ./Install-Zafiro-Icons.sh
    fi
    cp -r "$CFGDIR"/gtk-3.0 ~/.config/
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
    xdg-mime default nsxiv.desktop image/bmp image/gif image/jpeg image/jpg \
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
    if [ ! $(grep -q greeter.jpg /etc/lightdm/lightdm-gtk-greeter.conf) ]; then
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

config_fcitx(){
    ELOG 'CONFIGURING FCITX5'
    cp -r "$CFGDIR"/fcitx5 ~/.config/
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
        config_powerline
        config_tab_completion
        config_aliases
        config_nerdfont
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

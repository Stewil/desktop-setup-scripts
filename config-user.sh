#!/usr/bin/env bash
# thanks to https://www.pixiv.net/en/users/21549100 for the lovely bg illustration
# thanks to https://www.pixiv.net/en/users/3069527 for the lovely greeter illustration
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR=$ROOTDIR/config

config_i3(){
    echo "CONFIGURING I3"
	cp -r "$CFGDIR"/i3/ ~/.config/
}

config_rofi(){
    echo "CONFIGURING ROFI"
	cp -r "$CFGDIR"/rofi ~/.config/
}

config_picom(){
    echo "CONFIGURING PICOM"
	cp -r "$CFGDIR"/picom ~/.config/
}

config_powerline(){
    echo "CONFIGURING POWERLINE"
	cp -r "$CFGDIR"/powerline ~/.config/
}

config_neovim(){
    echo "CONFIGURING NEOVIM"
    if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
        curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
	cp -r "$CFGDIR"/nvim ~/.config/
    sudo ln -s /usr/bin/nvim /usr/bin/editor
    sudo ln -s /usr/bin/nvim /usr/bin/edit
    sudo ln -s /usr/bin/nvim /usr/bin/vi
    sudo ln -s /usr/bin/nvim /usr/bin/vim
    nvim +PlugInstall +qall
}

config_nerdfont(){
    echo "CONFIGURING NERDFONTS"
    NFDIR="/usr/share/fonts/truetype/nerdfonts"
    if [ ! -d "$NFDIR" ]; then
        mkdir -p "$NFDIR"
    fi
    if [ ! -f "$NFDIR/Hack Regular Nerd Font Complete.ttf" ]; then
        echo "INSTALLING NERDFONT: HACK"
        wget -O /tmp/hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip
        sudo bash -c "cd /tmp && unzip hack.zip && cp Hack* $NFDIR/ || echo 'ERROR INSTALLING NF HACK'"
    fi
}

config_aliases(){
    echo "CONFIGURING ALIASES"
	cp -r "$CFGDIR"/aliases ~/.aliases
	cp -r "$CFGDIR"/bashrc ~/.bashrc
}

config_xinit(){
    echo "CONFIGURING XINIT"
	cp "$CFGDIR"/xinitrc ~/.xinitrc
    cp "$CFGDIR"/bash_login ~/.bash_login
    rm ~/.bash_profile
}

config_themes(){
    echo "CONFIGURING THEMES"
    cp "$CFGDIR"/Xresources ~/.Xresources
    mkdir -p ~/.themes
    if [ ! -d ~/.themes/Nordic ]; then
        git clone https://github.com/EliverLara/Nordic.git ~/.themes/Nordic
    fi
    if [ ! -d ~/.themes/firefox-nordic-theme ]; then
        git clone https://github.com/EliverLara/firefox-nordic-theme ~/.themes/firefox-nordic-theme/ && ~/.themes/firefox-nordic-theme/scripts/install.sh 
    fi
    if [ ! -d ~/.local/share/icons/Zafiro-Icons-Dark/ ]; then
        wget -N https://raw.githubusercontent.com/zayronxio/Zafiro-icons/master/Install-Zafiro-Icons.sh && chmod +x Install-Zafiro-Icons.sh && bash ./Install-Zafiro-Icons.sh
    fi
    cp -r "$CFGDIR"/gtk-3.0 ~/.config/
}

config_lightdm(){
    DIST=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
    if [ "$DIST" != "ubuntu" ]; then
        echo "CONFIGURING LIGHTDM"
        sudo cp "$CFGDIR"/lightdm.conf /etc/lightdm/lightdm.conf
    fi
}

config_touchpad(){
    echo "CONFIGURING TOUCHPAD"
    sudo cp "$CFGDIR"/71-synaptics.conf /usr/share/X11/xorg.conf.d/71-synaptics.conf

}

config_pcspkr(){
    echo "CONFIGURING PCSPKR"
    sudo cp "$CFGDIR"/nobeep.conf /etc/modprobe.d/nobeep.conf

}

config_defaults(){
    echo "CONFIGURING DEFAULT APPLICATIONS"
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
    echo "CONFIGURING WALLPAPER"
    if [ ! -f ~/Pictures/wp/bg.jpg ]; then
    mkdir -p ~/Pictures/wp
    wget -O ~/Pictures/wp/bg.jpg \
        --referer='https://www.pixiv.net/en/artworks/85281138' \
        https://i.pximg.net/img-original/img/2020/10/27/23/47/17/85281138_p0.jpg
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
    echo "CONFIGURING GREETER"
    if [ ! -f /usr/share/pixmaps/greeter.jpg ]; then
    sudo mkdir -p /usr/share/pixmaps
    sudo wget -O /usr/share/pixmaps/greeter.jpg \
        --referer='https://www.pixiv.net/en/artworks/91390457' \
        https://i.pximg.net/img-original/img/2021/07/21/11/40/10/91390457_p0.jpg
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

configure_user(){
    config_i3
    config_rofi
    config_picom
    config_powerline
    config_aliases
    config_nerdfont
    config_neovim
    config_themes
    config_touchpad
    config_pcspkr
    config_lightdm
    config_wallpaper
    config_greeter
}

configure_user

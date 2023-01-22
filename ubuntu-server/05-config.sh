#!/bin/bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR="${ROOTDIR}/config/"
USERNAME="$(whoami)"

i3Conf(){
    cp -r "$CFGDIR"/i3 ~/.config/
}

rofiConf(){
    cp -r "$CFGDIR"/rofi ~/.config/
}

picomConf(){
    cp -r "$CFGDIR"/picom ~/.config/
}

neovimConf(){
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cp -r "$CFGDIR"/nvim ~/.config/
}

envConf(){
        cat "${CFGDIR}/profile" >> ~/.profile 
}

aliasConf(){
    cp -r "$CFGDIR"/aliases ~/.aliases
    echo "source ~/.aliases" >> ~/.bashrc
}

themeConf(){
    cp -r "$CFGDIR"/themes ~/.config/
    cp "$CFGDIR"/Xresources ~/.Xresources
}

configure_user(){
    i3Conf
    rofiConf
    picomConf
    neovimConf
    envConf
    aliasConf
}

read -p "Do you want to copy configurations for user [${USERNAME}]? (yes/no) " yn
yn=$(echo ${yn} | tr '[:upper:]' '[:lower:]')
echo "answer is ${yn}"
case $yn in
    no|n)
        exit 0;;
    yes|y)
        configure_user;;
    *)
        exit 1;;
esac

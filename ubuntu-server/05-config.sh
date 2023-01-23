#!/bin/bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR="${ROOTDIR}/config"
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

aliasConf(){
    cp -r "$CFGDIR"/aliases ~/.aliases
    echo "source ~/.aliases" >> ~/.bashrc
}

themeConf(){
    cp "$CFGDIR"/Xresources ~/.Xresources
    mkdir ~/.themes
    git clone https://github.com/EliverLara/Nordic.git ~/.themes/Nordic
    git clone https://github.com/EliverLara/firefox-nordic-theme ~/.themes/firefox-nordic-theme/ && ~/.themes/firefox-nordic-theme/scripts/install.sh 
    wget -N https://raw.githubusercontent.com/zayronxio/Zafiro-icons/master/Install-Zafiro-Icons.sh && chmod +x Install-Zafiro-Icons.sh && bash ./Install-Zafiro-Icons.sh
    cp -r "$CFGDIR"/gtk-3.0 ~/.config/
}

powerlineConf(){
    curl https://raw.githubusercontent.com/riobard/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh
    echo "source ~/.bash-powerline.sh" >> ~/.bashrc
    source ~/.bash-powerline.sh
}

configure_user(){
    i3Conf
    rofiConf
    picomConf
    neovimConf
    aliasConf
    themeConf
    powerlineConf
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

#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR=$ROOTDIR/config

config_i3(){
    echo "CONFIGURING I3"
	cp -r "$CFGDIR"/i3 ~/.config/
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

config_touchpad(){
    echo "CONFIGURING TOUCHPAD"
    sudo cp "$CFGDIR"/71-synaptics.conf /usr/share/X11/xorg.conf.d/71-synaptics.conf

}

config_pcspkr(){
    echo "CONFIGURING TOUCHPAD"
    sudo cp "$CFGDIR"/nobeep.conf /etc/modprobe.d/nobeep.conf

}

config_defaults(){
    echo "CONFIGURING DEFAULT APPLICATIONS"
    xdg-mime default thunar.desktop inode/directory
}

configure_user(){
    config_i3
    config_rofi
    config_picom
    config_powerline
    config_aliases
    config_xinit
    config_neovim
    config_themes
    config_touchpad
    config_pcspkr
}

configure_user

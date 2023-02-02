#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR=$ROOTDIR/config
USERNAME="$(whoami)"

config_i3(){
    i3_dir="/home/$USERNAME/.config/i3"
	cp -r "$CFGDIR"/i3/ ~/.config/
    DIST=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
    case $DIST in
        "ubuntu")
            echo "Configuring i3 for dist: $DIST"
            mv $i3_dir/ubuntu-config $i3_dir/config
            rm $i3_dir/arch-config
            ;;
        "arch") 
            echo "Configuring i3 for dist: $DIST"
            mv $i3_dir/arch-config $i3_dir/config
            rm $i3_dir/ubuntu-config
            ;;
        *) 
            echo "Configuring i3 for default, unknown dist: $DIST"
            mv $i3_dir/arch-config $i3_dir/config
            rm $i3_dir/ubuntu-config
            ;;
    esac
}

config_rofi(){
    echo "CONFIGURING ROFI"
	cp -r "$CFGDIR"/rofi ~/.config/
}

config_picom(){
    echo "CONFIGURING PICOM"
	cp -r "$CFGDIR"/picom ~/.config/
}

config_neovim(){
    echo "CONFIGURING NEOVIM"
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
    line="source /home/$USERNAME/.aliases"
    file="/home/$USERNAME/.bashrc"
    if ! grep -Fxq "$line" "$file"; then 
	    echo $line >> ~/.bashrc
    fi
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
    git clone https://github.com/EliverLara/Nordic.git ~/.themes/Nordic
    git clone https://github.com/EliverLara/firefox-nordic-theme ~/.themes/firefox-nordic-theme/ && ~/.themes/firefox-nordic-theme/scripts/install.sh 
    wget -N https://raw.githubusercontent.com/zayronxio/Zafiro-icons/master/Install-Zafiro-Icons.sh && chmod +x Install-Zafiro-Icons.sh && bash ./Install-Zafiro-Icons.sh
    cp -r "$CFGDIR"/gtk-3.0 ~/.config/
}

config_powerline(){
    echo "CONFIGURING THEMES"
    curl https://raw.githubusercontent.com/riobard/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh
    line="source /home/$USERNAME/.bash-powerline.sh"
    file="/home/$USERNAME/.bashrc"
    if ! grep -Fxq "$line" "$file"; then 
	    echo $line >> ~/.bashrc
    fi
    source ~/.bash-powerline.sh
}

configure_user(){
    config_i3
    config_rofi
    config_picom
    config_neovim
    config_aliases
    config_xinit
    config_themes
    config_powerline
}

configure_user

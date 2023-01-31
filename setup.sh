#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
USERNAME="$(whoami)"
source $ROOTDIR/utils.sh

setup_ubuntu_server(){
    dir=$ROOTDIR/ubuntu-i3
    source $dir/00-prep.sh
    source $dir/01-network.sh
    source $dir/02-ui.sh
    source $dir/03-audio.sh
    source $dir/04-software.sh
}

setup_arch(){
    dir=$ROOTDIR/arch-i3
    source $dir/00-prep.sh
    source $dir/01-network.sh
    source $dir/02-ui.sh
    source $dir/03-audio.sh
    source $dir/04-software.sh
    source $dir/05-japanese.sh
}

setup(){
    case DIST in
        "Ubuntu") setup_ubuntu_server ;;
        "Arch") setup_arch ;;
        *) echo "No setup found for $(DIST)";;
    esac
}

setup

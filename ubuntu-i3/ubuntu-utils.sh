#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
source "$ROOTDIR/../script-utils.sh"

ADD(){
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends "$@" > /dev/null
}

REMOVE(){
    sudo DEBIAN_FRONTEND=noninteractive apt-get purge -y "$@" > /dev/null
}

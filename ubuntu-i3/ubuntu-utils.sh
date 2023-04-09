#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR="${ROOTDIR}/config/"

ADD(){
    sudo DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends "$@"
}

REMOVE(){
    sudo DEBIAN_FRONTEND=noninteractive apt purge -y "$@"
}

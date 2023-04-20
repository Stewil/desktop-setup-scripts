#!/usr/bin/env bash
ROOTDIR=$(dirname $(realpath "$0"))
CFGDIR="${ROOTDIR}/config/"

ADD(){
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends "$@"
}

REMOVE(){
    sudo DEBIAN_FRONTEND=noninteractive apt-get purge -y "$@"
}

#!/bin/bash

# print to stderr to bypass stdout suppression
ELOG(){
    printf "%s\n" "$*" >&2;
}

export -f ELOG

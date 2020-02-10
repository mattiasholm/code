#!/bin/bash

function cpbak() {
    if [[ -f "$2" ]]; then
        mv "$2" "$2.bak"
    fi

    cp "$1" "$2"
}

function main() {
    cpbak $(git rev-parse --show-toplevel)/macOS/.bash_profile ~/.bash_profile
    cpbak $(git rev-parse --show-toplevel)/bash/.bashrc ~/.bashrc
}

main

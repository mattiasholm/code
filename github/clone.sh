#!/usr/bin/env bash

set -e

function setVariables() {
    path=~/repos
    urls=(
        'https://github.com/mattiasholm/code.git'
        'https://github.com/mattiasholm/drinks.git'
        'https://github.com/mattiasholm/lyrics.git'
        'https://github.com/mattiasholm/tunes.git'
    )
}

function cloneRepos() {
    mkdir -p "$path" &&
        cd "$_"

    echo ''

    for url in ${urls[*]}; do
        name=$(basename "$url" | sed 's/.git$//')

        if [[ ! -d "$path/$name" ]]; then
            echo "Want to clone $url? (y/n)"
            read confirm

            if [[ $confirm == 'y' ]]; then
                echo -e "Cloning $name\n"
                git clone "$url"
            fi
        else
            echo -e "Git repo $name already exists, skipping\n"
        fi
    done
}

function main() {
    setVariables
    cloneRepos
}

main

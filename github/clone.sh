#!/usr/bin/env bash

set -e

function setVariables() {
    path=~/repos
    baseUrl='https://github.com/mattiasholm'
    repos=(
        'mattiasholm'
        'mattiasholm.github.io'
        'code'
        'drinks'
        'tunes'
        'dives'
        'lyrics'
    )
}

function cloneRepos() {
    mkdir -p "$path" &&
        cd "$_"

    echo ''

    for name in ${repos[*]}; do
        url="$baseUrl/$name.git"

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

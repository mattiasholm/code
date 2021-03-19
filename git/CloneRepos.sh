#!/usr/bin/env bash

set -e +x

function SetVariables() {
    path=~/repos
    urls=(
        "https://github.com/mattiasholm/code.git"
        "https://github.com/mattiasholm/drinks.git"
        "https://github.com/mattiasholm/lyrics.git"
    )
}

function CloneRepos() {
    mkdir -p "${path}" &&
        cd "$_"

    echo -e ""

    for url in "${urls[@]}"; do

        name=$(basename "${url}" | sed "s/.git$//")

        if [[ ! -d "${path}/${name}" ]]; then
            echo -e "Want to clone ${url}? (y/n)"
            read confirm

            if [[ ${confirm} == "y" ]]; then
                echo -e "Cloning ${name}\n"
                git clone "${url}"
            fi
        else
            echo -e "Git repo ${name} already exists, skipping\n"
        fi
    done
}

function main() {
    SetVariables
    CloneRepos
}

main

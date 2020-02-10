#!/bin/bash

function cloneRepos() {
    . "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}" | sed 's/[.].*$/.\env/')"

    mkdir -p $path && cd $path
    echo -e ""

    for url in ${urls[@]}; do

        name=$(basename $url | sed "s/.git$//")

        if [[ ! -d "$path/$name" ]]; then
            echo -e "Want to clone $url? (y/n)\n"
            read confirm

            if [[ $confirm == "y" ]]; then
                echo -e "Cloning $name\n"
                git clone $url
            fi
        else
            echo -e "Git repo $name already exists, skipping\n"
        fi
    done
}

function main() {
    cloneRepos
}

main

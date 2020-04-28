#!/usr/bin/env bash

function SetVariables() {
    path=~/repos
    urls=(
        "https://github.com/mattiasholm/mattiasholm.git"
        "https://github.com/mattiasholm/lyrics.git"
        "https://B3Cloud@dev.azure.com/B3Cloud/B3CAF/_git/B3CAF-ARM-Governance"
        "https://B3Cloud@dev.azure.com/B3Cloud/B3CAF/_git/B3CAF-ARM-Library"
        "https://github.com/hi3g-access/tre-se-deployment.git"
        "https://github.com/hi3g-access/tre-se-infra.git"
        "https://DevOpsAlmi@dev.azure.com/DevOpsAlmi/Infrastructure/_git/Almi-Infrastructure-Governance"
    )
}

function CloneRepos() {
    mkdir -p "${path}" &&
        cd "${path}"

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

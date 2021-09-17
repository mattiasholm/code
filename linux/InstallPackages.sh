#!/usr/bin/env bash

set -e +x

path=~/repos/code
cd "${path}"

userName="Mattias Holm"
userEmail="mattias.holm@live.com"
topLevel="$(git rev-parse --show-toplevel)"

. "${topLevel}/bash/.bashrc"
.b

sudo apt install -y git &&
    git config --global user.name "${userName}" &&
    git config --global user.email "${userEmail}" &&
    git config --global credential.helper 'cache --timeout=86400' &&
    git config --global init.defaultBranch main &&
    chmod +x "${topLevel}/git/cloneRepos.sh" &&
    "${topLevel}/git/cloneRepos.sh"

sudo apt install -y python3

wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb &&
    sudo dpkg -i packages-microsoft-prod.deb &&
    sudo apt-get update &&
    sudo add-apt-repository universe &&
    sudo apt-get install -y powershell &&
    rm -rf packages-microsoft-prod.deb

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

sudo apt-get update &&
    sudo apt-get install -y apt-transport-https &&
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - &&
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list &&
    sudo apt-get update &&
    sudo apt-get install -y kubectl

curl -fsSL https://get.pulumi.com | sh

sudo apt update &&
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common &&
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" &&
    sudo apt update &&
    apt-cache policy docker-ce &&
    sudo apt install -y docker-ce

sudo apt install -y jq

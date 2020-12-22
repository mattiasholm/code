#!/usr/bin/env bash

set -e +x

sudo apt-get update &&
    sudo apt-get upgrade --assume-yes &&
    sudo apt-get dist-upgrade --assume-yes &&
    sudo apt-get clean --assume-yes

#!/usr/bin/env bash

set -e +x

brew update &&
    brew upgrade &&
    brew upgrade --cask &&
    brew cleanup

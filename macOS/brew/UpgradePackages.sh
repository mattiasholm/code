#!/usr/bin/env bash

brew update &&
    brew upgrade &&
    brew upgrade --cask &&
    brew cleanup

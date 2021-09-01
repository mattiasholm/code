#!/usr/bin/env bash

set -e +x

path="./arm-ttk/arm-ttk/arm-ttk.psd1"
templateFile="main.json"
command="Test-AzTemplate -MainTemplateFile ${templateFile} -TemplatePath ${templateFile}"

pwsh -Command "Import-Module -FullyQualifiedName ${path}; ${command}; if (\$error.Count) { exit 1 }"

# HAR KÖRT IFRÅN azure/arm directory:
# git submodule
# git submodule status
# git submodule update
# git submodule update --init --recursive
# git submodule init
# git clone --recurse-submodules
# git submodule -h
# FYLL PÅ: https://git-scm.com/book/en/v2/Git-Tools-Submodules
# Ev flytta till mer logisk plats än längst ned i README?

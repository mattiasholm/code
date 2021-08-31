#!/usr/bin/env bash

set -e +x

path="./arm-ttk/arm-ttk/arm-ttk.psd1"
templateFile="main.json"
command="Test-AzTemplate -MainTemplateFile ${templateFile} -TemplatePath ${templateFile}"

pwsh -Command "Import-Module -FullyQualifiedName ${path}; ${command}; if (\$error.Count) { exit 1 }"

# - name: Show ARM TTK test result
#   shell: bash
#   continue-on-error: true
#   run: |
#     echo 'Results: ${{ toJSON(fromJSON(steps.armtest.outputs.results)) }}'

# HAR KÖRT IFRÅN azure/arm directory:
# git submodule add https://github.com/Azure/arm-ttk
# git submodule
# git submodule status
# git submodule update
# git submodule update --init --recursive
# git submodule -h

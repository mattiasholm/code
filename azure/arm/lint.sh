#!/usr/bin/env bash

set -e +x

if [[ ! -d "arm-ttk" ]]; then
    git clone --depth 1 "https://github.com/Azure/arm-ttk"
fi

path="./arm-ttk/arm-ttk/arm-ttk.psd1"
templateFile="main.json"
command="Test-AzTemplate -MainTemplateFile ${templateFile} -TemplatePath ${templateFile}"

pwsh -Command "Import-Module -FullyQualifiedName ${path}; ${command}; if (\$error.Count) { exit 1 }"

rm -rf "arm-ttk/" # Hinner exita innan körs nu! Bättre med permanent submodule!

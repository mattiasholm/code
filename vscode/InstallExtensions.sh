#!/usr/bin/env bash

set -e +x

exts=(
    "foxundermoon.shell-format"
    "bmalehorn.vscode-fish"
    "ms-vscode.powershell"
    "ms-azuretools.vscode-bicep"
    "msazurermtools.azurerm-vscode-tools"
    "hashicorp.terraform"
    "ms-python.vscode-pylance"
    "josin.kusto-syntax-highlighting"
    "ms-azure-devops.azure-pipelines"
    "ms-azuretools.vscode-docker"
    "ms-mssql.mssql"
    "redhat.vscode-yaml"
    "dotjoshjohnson.xml"
    "mechatroner.rainbow-csv"
    "yzhang.markdown-all-in-one"
    "bierner.markdown-emoji"
    "bierner.markdown-footnotes"
    "waderyan.gitblame"
    "gurumukhi.selected-lines-count"
    "ms-vsliveshare.vsliveshare"
    "softaware.abc-music"
)

for ext in ${exts[@]}; do
    code --install-extension "$ext"
done

code --list-extensions --show-versions

#!/usr/bin/env bash

set -e +x

exts=(
    "foxundermoon.shell-format"
    "ms-vscode.powershell"
    "ms-python.vscode-pylance"
    "ms-azuretools.vscode-bicep"
    "msazurermtools.azurerm-vscode-tools"
    "hashicorp.terraform"
    "ms-azuretools.vscode-docker"
    "ms-mssql.mssql"
    "josin.kusto-syntax-highlighting"
    "redhat.vscode-yaml"
    "dotjoshjohnson.xml"
    "mechatroner.rainbow-csv"
    "softaware.abc-music"
    "yzhang.markdown-all-in-one"
    "bierner.markdown-emoji"
    "bierner.markdown-footnotes"
    "waderyan.gitblame"
    "gurumukhi.selected-lines-count"
    "ms-vsliveshare.vsliveshare"
)

for ext in ${exts[@]}; do
    code --install-extension "${ext}"
done

code --list-extensions --show-versions

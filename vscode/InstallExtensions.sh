#!/usr/bin/env bash

set -e +x

exts=(
    "ms-vscode.powershell"
    "foxundermoon.shell-format"
    "ms-python.python"
    "ms-azuretools.vscode-docker"
    "waderyan.gitblame"
    "ms-mssql.mssql"
    "redhat.vscode-yaml"
    "dotjoshjohnson.xml"
    "msazurermtools.azurerm-vscode-tools"
    "bencoleman.armview"
    "hashicorp.terraform"
    "josin.kusto-syntax-highlighting"
    "yzhang.markdown-all-in-one"
    "bierner.markdown-emoji"
    "bierner.markdown-footnotes"
    "pustelto.bracketeer"
    "vscode-icons-team.vscode-icons"
    "mechatroner.rainbow-csv"
    "ilich8086.untabify"
    "ms-azuretools.vscode-bicep"
    "ms-dotnettools.vscode-dotnet-runtime"
    "ms-toolsai.jupyter"
)

for ext in ${exts[@]}; do
    code --install-extension "${ext}"
done

code --list-extensions --show-versions

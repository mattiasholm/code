#!/usr/bin/env bash

set -e +x

exts=(
    "foxundermoon.shell-format"
    "ms-vscode.powershell"
    "ms-python.python"
    "yzhang.markdown-all-in-one"
    "bierner.markdown-emoji"
    "bierner.markdown-footnotes"
    "redhat.vscode-yaml"
    "mechatroner.rainbow-csv"
    "dotjoshjohnson.xml"
    "ilich8086.untabify"
    "pustelto.bracketeer"
    "waderyan.gitblame"
    "vscode-icons-team.vscode-icons"
    "ms-azuretools.vscode-bicep"
    "msazurermtools.azurerm-vscode-tools"
    "bencoleman.armview"
    "hashicorp.terraform"
    "ms-vscode.azure-account"
    "ms-azure-devops.azure-pipelines"
    "josin.kusto-syntax-highlighting"
    "ms-dotnettools.vscode-dotnet-runtime"
    "ms-azuretools.vscode-docker"
    "ms-mssql.mssql"
    "ms-toolsai.jupyter"
    "softaware.abc-music"
)

for ext in ${exts[@]}; do
    code --install-extension "${ext}"
done

code --list-extensions --show-versions

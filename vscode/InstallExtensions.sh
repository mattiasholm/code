#!/usr/bin/env bash

set -e +x

exts=(
    'ms-vscode.powershell'
    'foxundermoon.shell-format'
    'bmalehorn.vscode-fish'
    'ms-azuretools.vscode-bicep'
    'msazurermtools.azurerm-vscode-tools'
    'hashicorp.terraform'
    'ms-python.python'
    'ms-python.vscode-pylance'
    'ms-azure-devops.azure-pipelines'
    'josin.kusto-syntax-highlighting'
    'ms-azuretools.vscode-docker'
    'ms-mssql.mssql'
    'gsgben.fortigate-fortios-syntax'
    'adamhartford.vscode-base64'
    'redhat.vscode-yaml'
    'dotjoshjohnson.xml'
    'mechatroner.rainbow-csv'
    'yzhang.markdown-all-in-one'
    'bierner.markdown-emoji'
    'bierner.markdown-footnotes'
    'tht13.html-preview-vscode'
    'waderyan.gitblame'
    'gurumukhi.selected-lines-count'
    'ms-vsliveshare.vsliveshare'
    'hediet.vscode-drawio'
    'softaware.abc-music'
)

for ext in ${exts[@]}; do
    code --install-extension "$ext"
done

code --list-extensions --show-versions

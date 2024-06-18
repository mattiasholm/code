#!/usr/bin/env bash

set -e

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
    'bierner.markdown-mermaid'
    'bierner.markdown-footnotes'
    'tht13.html-preview-vscode'
    'cschleiden.vscode-github-actions'
    'waderyan.gitblame'
    'jasonnutter.vscode-codeowners'
    'gurumukhi.selected-lines-count'
    'ms-vsliveshare.vsliveshare'
    'hediet.vscode-drawio'
    'softaware.abc-music'
    'tonybaloney.vscode-pets'
)

for ext in ${exts[*]}; do
    code --install-extension $ext
done

echo -e '\n# Installed extensions:'

code --list-extensions --show-versions

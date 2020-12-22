#!/usr/bin/env bash

set -e +x

code --install-extension ms-vscode.powershell
code --install-extension foxundermoon.shell-format
code --install-extension ms-python.python
code --install-extension ms-azuretools.vscode-docker
code --install-extension waderyan.gitblame
code --install-extension ms-mssql.mssql
code --install-extension redhat.vscode-yaml
code --install-extension dotjoshjohnson.xml
code --install-extension msazurermtools.azurerm-vscode-tools
code --install-extension bencoleman.armview
code --install-extension hashicorp.terraform
code --install-extension josin.kusto-syntax-highlighting
code --install-extension yzhang.markdown-all-in-one
code --install-extension bierner.markdown-emoji
code --install-extension bierner.markdown-footnotes
code --install-extension pustelto.bracketeer
code --install-extension vscode-icons-team.vscode-icons
code --install-extension mechatroner.rainbow-csv
code --install-extension ilich8086.untabify
code --install-extension ms-azuretools.vscode-bicep
code --install-extension ms-dotnettools.vscode-dotnet-runtime
code --install-extension ms-toolsai.jupyter

code --list-extensions --show-versions

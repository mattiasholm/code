#!/usr/bin/env bash

set -e +x

topLevel=$(git rev-parse --show-toplevel)
linterPath="arm-ttk\/arm-ttk"
path=$(echo ${topLevel} | sed "s/$(basename ${topLevel})$/${linterPath}/")
templateFile="main.json"
linterCommand="Test-AzTemplate -MainTemplateFile ${templateFile} -TemplatePath ${templateFile}"

pwsh -Command "Import-Module -FullyQualifiedName '${path}/arm-ttk.psd1'; ${linterCommand}; if (\$error.Count) { exit 1 }"

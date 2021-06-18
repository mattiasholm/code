#!/usr/bin/env bash

set -e +x

topLevel=$(git rev-parse --show-toplevel)
childPath="arm-ttk\/arm-ttk\/arm-ttk.psd1"
path=$(echo ${topLevel} | sed s/$(basename ${topLevel})$/${childPath}/)
templateFile="main.bicep"

bicep=false
if [[ ${templateFile} =~ '.bicep' ]]; then
    bicep=true
    az bicep build --file ${templateFile}
    templateFile=$(echo ${templateFile} | sed 's/.bicep$/.json/')
fi

command="Test-AzTemplate -MainTemplateFile ${templateFile} -TemplatePath ${templateFile}"

pwsh -Command "Import-Module -FullyQualifiedName ${path}; ${command}; if (\$error.Count) { exit 1 }"

if [[ ${bicep} ]]; then
    rm ${templateFile}
fi

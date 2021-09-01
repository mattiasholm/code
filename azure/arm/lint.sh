#!/usr/bin/env bash

set -e +x

path="./arm-ttk/arm-ttk/arm-ttk.psd1"
templateFile="main.json"
command="Test-AzTemplate -MainTemplateFile ${templateFile} -TemplatePath ${templateFile}"

pwsh -Command "Import-Module -FullyQualifiedName ${path}; ${command}; if (\$error.Count) { exit 1 }"

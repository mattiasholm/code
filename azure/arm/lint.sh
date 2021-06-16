#!/usr/bin/env bash

topLevel=$(git rev-parse --show-toplevel)
childPath="arm-ttk\/arm-ttk"
path=$(echo ${topLevel} | sed "s/$(basename ${topLevel})$/${childPath}/")

${path}/Test-AzTemplate.sh

# Test-AzTemplate -MainTemplateFile

# Import-Module ./arm-ttk.psd1

# Test-AzTemplate -TemplatePath /path/to/template
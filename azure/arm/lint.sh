#!/usr/bin/env bash

set -e +x

if [[ ! -d "arm-ttk" ]]; then
    git clone --depth 1 "https://github.com/Azure/arm-ttk"
fi

path="./arm-ttk/arm-ttk/arm-ttk.psd1"
templateFile="main.json"
command="Test-AzTemplate -MainTemplateFile ${templateFile} -TemplatePath ${templateFile}"

pwsh -Command "Import-Module -FullyQualifiedName ${path}; ${command}; if (\$error.Count) { exit 1 }"

rm -rf "arm-ttk/" # Hinner exita innan körs nu! Bättre med permanent submodule!



# hint: You've added another git repository inside your current repository.
# hint: Clones of the outer repository will not contain the contents of
# hint: the embedded repository and will not know how to obtain it.
# hint: If you meant to add a submodule, use:
# hint:
# hint: 	git submodule add <url> azure/arm/arm-ttk
# hint:
# hint: If you added this path by mistake, you can remove it from the
# hint: index with:
# hint:
# hint: 	git rm --cached azure/arm/arm-ttk
# hint:
# hint: See "git help submodule" for more information.
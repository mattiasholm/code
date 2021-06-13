#!/usr/bin/env pwsh

$TopLevel = git rev-parse --show-toplevel
$Path = $($TopLevel).Replace($(Split-Path -Leaf -Path $($TopLevel)), 'arm-ttk/unit-tests')

Set-Location -Path $Path

Import-Module ..\arm-ttk\arm-ttk.psd1 -Force

./arm-ttk.tests.ps1

# https://github.com/Azure/arm-ttk

# https://medium.com/swlh/validating-azure-arm-template-never-been-easier-f61781ee3e1
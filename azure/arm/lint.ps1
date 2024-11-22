#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

Set-Location $PSScriptRoot

Import-Module -FullyQualifiedName './arm-ttk/arm-ttk/arm-ttk.psd1'

function Get-Config {
    param (
        $Key
    )
    ((Get-Content 'config.sh' | Select-String "$Key=").ToString() -replace '^.+=').Trim("'")
}

$Template = Get-Config 'template'

Test-AzTemplate -TemplatePath $Template

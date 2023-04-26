#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

Set-Location $PSScriptRoot

function Get-Config {
    param (
        $Key
    )
    ((Get-Content 'config.sh' | Select-String "$Key=").ToString() -replace '^.+=').Trim("'")
}

$Module = Get-Config 'module'
$Template = Get-Config 'template'

Import-Module -FullyQualifiedName $Module
Test-AzTemplate -MainTemplateFile $Template -TemplatePath $Template
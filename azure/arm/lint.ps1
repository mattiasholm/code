#!/usr/bin/env pwsh

function Get-Config {
    param (
        $Key
    )
    ((Get-Content 'main.config' | Select-String "$Key=").ToString() -replace '^.+=').Trim("'")
}

$Module = Get-Config 'module'
$Template = Get-Config 'template'

Import-Module -FullyQualifiedName $Module
Test-AzTemplate -MainTemplateFile $Template -TemplatePath $Template

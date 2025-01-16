#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

Set-Location $PSScriptRoot

$Modules = @(
    'azure'
    'github'
    'sp'
)

foreach ($Module in $Modules) {
    terraform-docs markdown $Module > (Join-Path $Module 'README.md')
}

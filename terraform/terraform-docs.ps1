#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

Set-Location $PSScriptRoot

$Path = '.'
$Modules = Get-ChildItem $Path -Name -Directory

foreach ($Module in $Modules) {
    terraform-docs markdown $Module > (Join-Path $Module 'README.md')
}

#!/usr/bin/env pwsh

function Get-RandomJsonFile {
    [alias("grjf")]
    [cmdletbinding(SupportsShouldProcess = $True)]
    param (
        [parameter(position = 1, Mandatory = $false)]
        [int]
        [ValidateRange(0, 10)]
        $Count = 1
    )
    $Arguments = @{
        Path    = '~/repos'
        Recurse = $True
        Filter  = "*.json"
    }

    Get-ChildItem @Arguments | Get-Random -Count $Count | Invoke-Item
}

Get-RandomJsonFile 10 -WhatIf
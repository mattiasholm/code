#!/usr/bin/env pwsh

param
(
    [Parameter(
        Mandatory,
        Position = 0,
        HelpMessage = 'Enter path to check if exists.')]
    [string] $Path
)

$Items = Get-ChildItem -Path $Path

foreach ($Item in $Items) {
    Write-Host -NoNewline -ForegroundColor Green "$($Item.Name) "
    Write-Host -NoNewline "of size "
    Write-Host -ForegroundColor Magenta "$($Item.Length)"
}
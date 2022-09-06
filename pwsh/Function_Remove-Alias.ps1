#!/usr/bin/env pwsh

function Remove-Alias {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Name
    )
    $Path = "Alias:\$Name"
    if (Test-Path ($Path)) {
        Remove-Item -Path $Path -Confirm:$false
    }
    else {
        throw "Alias $Name does not exist."
    }
}

New-Alias -Name foo -Value bar

Remove-Alias -Name foo
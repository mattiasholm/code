New-Alias -Name 'll' -Value 'Get-ChildItem' -Force
New-Alias -Name 'l' -Value 'll' -Force
New-Alias -Name 'cl' -Value 'Clear-Host' -Force

function la {
    Get-ChildItem -Force
}

function .. {
    Set-Location ..
}

function ... {
    Set-Location ../..
}

function .... {
    Set-Location ../../..
}

function ..... {
    Set-Location ../../../..
}

function ...... {
    Set-Location ../../../../..
}

function prompt {
    $Hostname = $(hostname)
    $Username = [Environment]::UserName
    $Path = (Get-Location).Path
    $Branch = git rev-parse --abbrev-ref HEAD 2> $null
    $Suffix = ' $ '

    Write-Host -ForegroundColor Green $($Username + '@' + $Hostname) -NoNewline
    Write-Host ':' -NoNewline
    Write-Host -ForegroundColor Magenta $Path.Replace($HOME, '~') -NoNewline
    if ($Branch) { Write-Host -ForegroundColor Cyan $(' (' + $Branch + ')') -NoNewline }
    return $Suffix
}

function .p {
    $Path = '~/repos/code'
    Copy-Item -Path (Join-Path $Path 'pwsh' 'Microsoft.PowerShell_profile.ps1') -Destination $PROFILE
    pwsh -NoLogo
}

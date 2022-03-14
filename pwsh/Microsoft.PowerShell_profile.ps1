function prompt {
    $Hostname = $(hostname)
    $Username = [Environment]::UserName
    $Path = (Get-Location).Path
    $Branch = git rev-parse --abbrev-ref HEAD 2> $null
    $Suffix = ' $ '

    Write-Host -ForegroundColor Green $($Username + '@' + $Hostname)  -NoNewline
    Write-Host ':' -NoNewline
    Write-Host -ForegroundColor Magenta $Path.Replace($HOME, '~')  -NoNewline
    if ($Branch) { Write-Host -ForegroundColor Cyan $(' (' + $Branch + ')') -NoNewline }
    return $Suffix
}

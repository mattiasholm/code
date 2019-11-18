$Path = "C:\Temp"

if (!(Test-Path $Path))
{
    $Path = Read-Host -Prompt "Enter path"
}    

$Items = Get-ChildItem -Path $Path


foreach ($Item in $Items)
{
    Write-Host -NoNewline -ForegroundColor Green "$($Item.Name) "
    Write-Host -NoNewline "of size "
    Write-Host -ForegroundColor Magenta "$($Item.Length)"
}
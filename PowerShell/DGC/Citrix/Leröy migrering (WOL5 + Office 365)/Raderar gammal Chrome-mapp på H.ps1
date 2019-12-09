$OUname = "Demo"


$ErrorActionPreference = "Stop"

$HomeFolders = Get-ChildItem "\\emcat.com\wo\customers\$OUname\Home"

foreach ($HomeFolder in $HomeFolders)
{
if (Get-ChildItem "\\emcat.com\wo\customers\$OUname\Home\$HomeFolder" | where {$_.Name -eq "Chrome"})
{
Remove-Item "\\emcat.com\wo\customers\$OUname\Home\$HomeFolder\Chrome" -Confirm:$false -Recurse:$true
Write-Host "Raderar Chrome-mappen för $($HomeFolder.Name)"
}
}
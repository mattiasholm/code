$Recipients.Count
$DomainName = "itrim.se"

for ($i = 1; $i -le $Recipients.Count; $i++) 
{ 
Write-Progress -Id 1 -Activity "Exporting $($Recipients.Count) recipients for $DomainName" -Status "$([Math]::Floor([decimal]($i / $Recipients.Count * 100)))% complete" -PercentComplete ($i / $Recipients.Count * 100)
sleep -Milliseconds 10
}
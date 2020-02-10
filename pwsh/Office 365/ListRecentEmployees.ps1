Connect-MsolService

$Date = ([DateTime](Get-Date -Format yyyy-MM)).AddMonths(-3)

Get-MsolUser -All | Where-Object {$_.WhenCreated -ge $Date -and $_.Licenses -ne $null} | 
Select-Object DisplayName,Office,@{Name="Email";Expression={($_.proxyAddresses -cmatch 'SMTP:').Replace('SMTP:','')}},WhenCreated,@{Name='Licenses';Expression={$_.Licenses.AccountSkuId -join ', '}} | 
Sort-Object -Property WhenCreated | 
Export-Csv -NoTypeInformation -Encoding Unicode -Path "C:\Temp\Lista nya anställda sedan $(Get-Date $Date -Format yyyy-MM-dd).csv"

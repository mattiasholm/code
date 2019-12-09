Get-ChildItem "C:\Windows\Temp" | Where-Object {$_.Name -like "*.tmp" -and $_.LastWriteTime -lt (Get-date).AddDays(-30)} | Remove-Item

Get-ChildItem "C:\Windows\Temp" | Where-Object {$_.Name -like "*.tmp"} | Measure-Object
#!/usr/bin/env pwsh

$Path = Read-Host -Prompt "Enter path to a CSV file with a column named 'IpRange'"

$CsvFile = Import-Csv -Path $Path
$CsvString = $null

foreach ($Row in $CsvFile) {
    $CsvString += "$($Row.IpRange),"
}

$CsvString = $CsvString.TrimEnd(',')
Write-Host $CsvString
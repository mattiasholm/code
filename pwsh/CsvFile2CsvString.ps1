#!/usr/bin/env pwsh

param
(
    [Parameter(Mandatory,HelpMessage='Enter the path to a CSV file with a column named "IpRange".')]$CsvPath
)

$CsvFile = Import-Csv -Path $CsvPath
$CsvString = $null

foreach ($Row in $CsvFile) {
    $CsvString += "$($Row.IpRange),"
}

$CsvString = $CsvString.TrimEnd(',')
Write-Host $CsvString
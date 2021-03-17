#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'
$i = 0

$Day = [System.DateTime]::Today

Write-Host -ForegroundColor Green "Friday the 13th will occur on: "
while ($i -lt 10) {
    $Day = $Day.AddDays(1)

    if ($Day.DayOfWeek -eq 'Friday' -and $Day.Day -eq 13) {
        Write-Host -ForegroundColor Red "$($Day.ToString('dd MMMM yyyy'))"
        $i++
    }
}
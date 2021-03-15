#!/usr/bin/env pwsh

param
(
    [Parameter(Mandatory, HelpMessage = 'Enter your monthly salary.')]$MonthlySalary,
    [switch]$ShowCalculations = $false
)

$OnCallStart = Get-Date '2020-01-09 17:00'
$OnCallEnd = Get-Date '2020-01-16 08:00'

$OfficeHoursStart = Get-Date '08:00'
$OfficeHoursEnd = Get-Date '17:00'

$Rate1 = $MonthlySalary / 1400
$Rate2 = $MonthlySalary / 900
$Rate3 = $MonthlySalary / 600

$CurrentRate = 0
$TotalPay = 0

$OnCallHour = $OnCallStart

do {
    switch ($OnCallHour.DayOfWeek) {
        Monday {
            if ($OnCallHour.Hour -ge $OfficeHoursEnd.Hour -or $OnCallHour.Hour -lt $OfficeHoursStart.Hour) {
                $CurrentRate = $Rate1
                if ($ShowCalculations) { Write-Host "$($OnCallHour.DayOfWeek) - $($OnCallHour.ToString('HH:mm')) - $([Math]::Round($CurrentRate,2)) SEK" }
                $TotalPay += $CurrentRate
            }
        }
        Tuesday {
            if ($OnCallHour.Hour -ge $OfficeHoursEnd.Hour -or $OnCallHour.Hour -lt $OfficeHoursStart.Hour) {
                $CurrentRate = $Rate1
                if ($ShowCalculations) { Write-Host "$($OnCallHour.DayOfWeek) - $($OnCallHour.ToString('HH:mm')) - $([Math]::Round($CurrentRate,2)) SEK" }
                $TotalPay += $CurrentRate
            }
        }
        Wednesday {
            if ($OnCallHour.Hour -ge $OfficeHoursEnd.Hour -or $OnCallHour.Hour -lt $OfficeHoursStart.Hour) {
                $CurrentRate = $Rate1
                if ($ShowCalculations) { Write-Host "$($OnCallHour.DayOfWeek) - $($OnCallHour.ToString('HH:mm')) - $([Math]::Round($CurrentRate,2)) SEK" }
                $TotalPay += $CurrentRate
            }
        }
        Thursday {
            if ($OnCallHour.Hour -ge $OfficeHoursEnd.Hour -or $OnCallHour.Hour -lt $OfficeHoursStart.Hour) {
                $CurrentRate = $Rate1
                if ($ShowCalculations) { Write-Host "$($OnCallHour.DayOfWeek) - $($OnCallHour.ToString('HH:mm')) - $([Math]::Round($CurrentRate,2)) SEK" }
                $TotalPay += $CurrentRate
            }   
        }
        Friday {
            if ($OnCallHour.Hour -ge $OfficeHoursEnd.Hour -or $OnCallHour.Hour -lt $OfficeHoursStart.Hour) {
                if ($OnCallHour.Hour -lt 18) {
                    $CurrentRate = $Rate1
                    if ($ShowCalculations) { Write-Host "$($OnCallHour.DayOfWeek) - $($OnCallHour.ToString('HH:mm')) - $([Math]::Round($CurrentRate,2)) SEK" }
                    $TotalPay += $CurrentRate
                }
                else {
                    $CurrentRate = $Rate2
                    if ($ShowCalculations) { Write-Host "$($OnCallHour.DayOfWeek) - $($OnCallHour.ToString('HH:mm')) - $([Math]::Round($CurrentRate,2)) SEK" }
                    $TotalPay += $CurrentRate
                }
            }
        }
        Saturday {
            if ($OnCallHour.Hour -lt 07) {
                $CurrentRate = $Rate2
                if ($ShowCalculations) { Write-Host "$($OnCallHour.DayOfWeek) - $($OnCallHour.ToString('HH:mm')) - $([Math]::Round($CurrentRate,2)) SEK" }
                $TotalPay += $CurrentRate
            }
            else {
                $CurrentRate = $Rate3
                if ($ShowCalculations) { Write-Host "$($OnCallHour.DayOfWeek) - $($OnCallHour.ToString('HH:mm')) - $([Math]::Round($CurrentRate,2)) SEK" }
                $TotalPay += $CurrentRate
            }
        }
        Sunday {
            $CurrentRate = $Rate3
            if ($ShowCalculations) { Write-Host "$($OnCallHour.DayOfWeek) - $($OnCallHour.ToString('HH:mm')) - $([Math]::Round($CurrentRate,2)) SEK" }
            $TotalPay += $CurrentRate
        }
    }

    $OnCallHour = $OnCallHour.AddHours(1)
} until ($OnCallHour -eq $OnCallEnd)

Write-Host "`nOn-call compensation:"
Write-Host -ForegroundColor Green "$([Math]::Round($TotalPay,2)) SEK"

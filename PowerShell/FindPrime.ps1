#!/usr/bin/env powershell

function Get-PrimeNumber {
    param (
        [parameter(position = 1, Mandatory = $false)]
        [int]
        [ValidateRange(0, [int]::MaxValue)]
        $Min = 0,
        [parameter(position = 2, Mandatory = $false)]
        [int]
        [ValidateRange(0, [int]::MaxValue)]
        $Max = 30
    )

    $PrimeNumbers = [System.Collections.ArrayList]@()

    if ($Min -lt 2) {
        $n = 2
    }
    else {
        $n = $Min
    }

    while ($n -le $Max) {
        $i = $n - 1
        $IsPrime = $true

        while ($i -gt 1) {
            if ($n % $i -eq 0) {
                $IsPrime = $false
                break
            }

            $i--
        }

        if ($IsPrime -eq $True) {
            $PrimeNumbers.Add($n) > $null
        }

        $n++
    }
    
    Write-Host $PrimeNumbers
}

function main {
    Get-PrimeNumber -Min 0 -Max 100
}

main
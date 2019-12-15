#!/usr/bin/env powershell

function Get-PrimeNumber {
    param (
        [parameter(position = 1, Mandatory = $false)]
        [int]
        $Min = 0,
        [parameter(position = 2, Mandatory = $false)]
        [int]
        $Max = 50
    )

    $PrimeNumbers = @()

    if ($Min -lt 2) {
        $n = 2
    }
    else {
        $n = $Min
    }

    do {
        $i = $n
        $IsPrime = $true

        while ($i -gt 2) {
            $i--
            if ($n % $i -eq 0) {
                $IsPrime = $false
                break
            }
        }

        if ($IsPrime -eq $True) {
            $PrimeNumbers += $n
        }

        $n++
    } until ($n -gt $Max)

    Write-Host $PrimeNumbers
    Write-Host $PrimeNumbers.GetType()
}

function main {
    Get-PrimeNumber -Min 0 -Max 0
}

main
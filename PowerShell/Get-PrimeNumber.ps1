#!/usr/bin/env powershell

function Get-PrimeNumber {
    param (
        [parameter(position = 1, Mandatory = $false)]
        [ValidateRange(0, 1000000)]
        [int]
        $Min = 0,
        [parameter(position = 2, Mandatory = $false)]
        [ValidateRange(0, 1000000)]
        [int]
        $Max = 50
    )

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
            Write-Host -NoNewline "$n "
        }

        $n++
    } until ($n -gt $Max)
}

function main {
    Get-PrimeNumber -Min 0 -Max 100
}

main
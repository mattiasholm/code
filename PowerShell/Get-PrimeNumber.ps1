function Get-PrimeNumber {
    param (
        [parameter(position = 1, Mandatory = $false)]
        [ValidateRange(2, 1000)]
        [int]
        $Max = 20
    )
    
    $n = 2

    do {
        $i = $n
        $IsPrime = $true

        while ($i -gt 2) {
            $i--
            if ($n % $i -eq 0) {
                $IsPrime = $false
            }
        }

        if ($IsPrime -eq $True) {
            Write-Host -NoNewline "$n "
        }

        $n++
    } until ($n -gt $Max)
}

Get-PrimeNumber -Max 100
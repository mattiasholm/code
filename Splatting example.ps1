function Get-RandomJsonFile {
    [alias("grjf")]
    [cmdletbinding(SupportsShouldProcess = $True)]
    param (
        [parameter(position = 1, Mandatory = $false)]
        [Int]
        [ValidateRange(0, 10)]
        $Count = 1
    )
    $Parameters = @{
        Path    = 'C:\Users\MattiasHolm\Documents\AzureRepos'
        Recurse = $True
        Filter  = "*.json"
    }

    Get-ChildItem @Parameters | Get-Random -Count $Count | Invoke-Item
}

Get-RandomJsonFile 10 -WhatIf
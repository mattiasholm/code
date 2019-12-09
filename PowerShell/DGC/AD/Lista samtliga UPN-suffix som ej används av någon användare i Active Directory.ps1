Add-PSSnapin Microsoft.Exchange*

$ObsoleteUpnSuffixes = @()
$UpnSuffixes = Get-UserPrincipalNamesSuffix

foreach ($UpnSuffix in $UpnSuffixes)
    {
    $SearchFilter = "*@$UpnSuffix"
    $Users = $null
    $Users = Get-ADUser -Filter {UserPrincipalName -like $SearchFilter}

    if (!$Users)
        {
        $ObsoleteUpnSuffixes += $UpnSuffix
        }
    }

$ObsoleteUpnSuffixes | Out-File -FilePath "C:\Temp\ObsoleteUpnSuffixes.txt"
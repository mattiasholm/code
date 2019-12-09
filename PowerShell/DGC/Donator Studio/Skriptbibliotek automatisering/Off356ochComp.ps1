$username = "apa@donator.se";
$Pwd = "xxx";

$password = $Pwd | ConvertTo-SecureString -asPlainText -Force
$Cred = New-Object PSCredential($username,$password)
Connect-MsolService -Credential $cred
$tenIDs=get-msolpartnercontract 

$FileName = "C:\Temp\$(get-date -f yyyMMdd)_O365Users.txt"
Out-File $FileName
ForEach ($tenID in $tenIDs)
{ 
    $Companies = Get-MsolCompanyInformation -TenantId $tenID.TenantId
    $Users = Get-MsolUser -All -TenantId $tenID.TenantId
    ForEach ($User in $Users)
    {
        "======"  | Out-File $FileName -append
        $User.UserPrincipalName  | Out-File $FileName -append
        $User.DisplayName  | Out-File $FileName  -append
        $User.Licenses.AccountSkuId | Out-File $FileName  -append
        $Companies.DisplayName  | Out-File $FileName  -append
    }
}

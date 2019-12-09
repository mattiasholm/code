$ErrorActionPreference = "Stop"
$Users = Get-ADUser -SearchBase "OU=Meritmind,DC=meritmind,DC=local" -Filter * -SearchScope OneLevel
$Output = @()

foreach ($User in $Users)
{
$lowercase = ("a","b","c","d","e","f","g","h","i","j","k","m","n","p","q","r","s","t","u","v","w","x","y","z")
$uppercase = ("A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z")
$symbols = ("!","#","%","&","$","@")
$p1 = Get-Random $lowercase
$p2 = Get-Random -Minimum 1 -Maximum 9
$p3 = Get-Random $uppercase
$p4 = Get-Random $symbols
$Password = "$p1$p1$p2$p2$p3$p3$p4$p4"

$Passwordlist = New-Object psobject
$Passwordlist | Add-Member noteproperty UserPrincipalName $User.UserPrincipalName
$Passwordlist | Add-Member noteproperty Password $Password
$Output += $Passwordlist

$SecureString = ConvertTo-SecureString -String $Password -AsPlainText -Force
Set-ADAccountPassword -Identity $User -NewPassword $SecureString
}

$Output | Export-Csv -Path "C:\temp\Meritmind_Passwordlist.csv" -Delimiter "," -Encoding Unicode
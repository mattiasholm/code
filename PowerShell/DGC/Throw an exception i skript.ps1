$Name = $null
#$Name = "Mattias"


if (!($Name))
{
#Throw "Parameter `$Name is mandatory!"
}

if ($Name)
{
Write-Host "Hej $Name!"
}
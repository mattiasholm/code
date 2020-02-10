$Path = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\Intune\Intune_reqports.csv"
$Ports = 443

$Endpoints = Import-Csv -Path $Path

foreach ($Endpoint in $Endpoints)
{
    if (!(Resolve-DnsName $Endpoint.Url -ErrorAction SilentlyContinue)) 
    {
        Write-Host -ForegroundColor Yellow "DNS lookup failed for URL: $($Endpoint.Url)"
        Throw "Resolve the DNS lookup problem or manually remove the failing entry from the imported list."
    }
    else
    {
        foreach ($Port in $Ports)
        {
            Test-NetConnection -ComputerName $Endpoint.Url -Port $Port
        }
    }
}
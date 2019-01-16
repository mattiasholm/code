$Uri = "https://s2events.azure-automation.net/webhooks?token=UO55k3VKisnTUNwQDUIC2%2f1E1RiOnhLcAdY0%2fNavzQA%3d"



$Json = @{Account="mattias.holm";Domain="b3.se"}
$Body = ConvertTo-Json -InputObject $Json
$Header = @{Message="SentFromMattiasHolm"}
$Response = Invoke-RestMethod -Method Post -Uri $Uri -Body $Body -Headers $Header
$JobId = $Response.JobIds

$JobId
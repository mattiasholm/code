$Uri = ""



$Json = @{Account="mattias.holm";Domain="b3.se"}
$Body = ConvertTo-Json -InputObject $Json
$Header = @{Message="SentFromMattiasHolm"}
$Response = Invoke-RestMethod -Method Post -Uri $Uri -Body $Body -Headers $Header
$JobId = $Response.JobIds

$JobId
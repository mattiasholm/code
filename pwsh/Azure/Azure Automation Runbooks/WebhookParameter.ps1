Param
(
    [Parameter (Mandatory = $false)]
    [Object] $WebhookData
)

if ($WebhookData) {
    if ($WebhookData.RequestHeader.Message -eq 'SentFromMattiasHolm') {
        Write-Output "Header has required information"
    }
    else {
        Write-Output "Header missing required information"
        exit
    }   

    Write-Output $WebhookData
    # Retrieve Obj's from Webhook request body
    $Objs = (ConvertFrom-Json -InputObject $WebhookData.RequestBody)

    foreach ($Obj in $Objs) {
        Write-Output $Obj.Account
        Write-Output $Obj.Domain
    }
}
else {
    # Error
    Write-Error "This runbook is meant to be started from an Azure alert webhook only."
}
$TagKey = "AutoShutdown"
$TagValues = "GroupC", "GroupB", "GroupA"

# $Conn = Get-AutomationConnection -Name AzureRunAsConnection
# Add-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

foreach ($TagValue in $TagValues) {
    "`nStopping VMs with tag `"{0}:{1}`":`n" -f $TagKey, $TagValue
    $VMs = Get-AzResource -TagName $TagKey -TagValue $TagValue | Where-Object { $_.ResourceType -eq "Microsoft.Compute/virtualMachines" }

    foreach ($VM in $VMs) {
        "{0} ({1})" -f $VM.Name, $VM.ResourceGroupName

        Stop-AzVM -Name $VM.Name -ResourceGroupName  $VM.ResourceGroupName -Force
    }

    foreach ($VM in $VMs) {
        while ((Get-AzVm -Name $VM.Name -ResourceGroupName $VM.ResourceGroupName -Status).Statuses.DisplayStatus[1] -notlike "*VM deallocated*") {
            "Waiting for `"{0}`" to stop..." -f $VM.Name
            Start-Sleep -Seconds 5
        }
    }

    if ($null -eq $VMs) {
        "-"
    }
    ""
}

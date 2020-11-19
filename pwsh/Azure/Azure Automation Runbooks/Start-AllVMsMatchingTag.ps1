$TagKey = "AutoShutdown"
$TagValues = "GroupA", "GroupB", "GroupC"

$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Add-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

foreach ($TagValue in $TagValues) {
  "`nStarting VMs with tag `"{0}:{1}`":`n" -f $TagKey, $TagValue
  $VMs = Get-AzResource -TagName $TagKey -TagValue $TagValue | Where-Object { $_.ResourceType -eq "Microsoft.Compute/virtualMachines" }

  foreach ($VM in $VMs) {
    "{0} ({1})" -f $VM.Name, $VM.ResourceGroupName

    Start-AzVM -Name $VM.Name -ResourceGroupName $VM.ResourceGroupName
  }

  if ($null -eq $VMs) {
    "-"
  }
  ""
}

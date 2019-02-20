Param
(
  [Parameter (Mandatory= $true)]
  [String] $VMName,

  [Parameter (Mandatory= $true)]
  [String] $ResourceGroup
)



$Conn = Get-AutomationConnection -Name AzureRunAsConnection

Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID `
-ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

Stop-AzureRmVM -Name $VMName -ResourceGroupName $ResourceGroup -Force #-StayProvisioned
# Don't use switch 'StayProvisioned' if the purpose of stopping the VM is reducing costs. In that case the VM needs to be Stopped and Deallocated.
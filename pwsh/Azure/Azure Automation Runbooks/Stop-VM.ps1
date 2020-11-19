Param
(
  [Parameter (Mandatory= $true)]
  [String] $VMName,

  [Parameter (Mandatory= $true)]
  [String] $ResourceGroup
)

$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Add-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

Stop-AzVM -Name $VMName -ResourceGroupName $ResourceGroup -NoWait -Force
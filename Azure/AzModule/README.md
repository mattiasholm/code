# Cheat Sheet

<br>

## List available API versions in the Azure Resource Manager API for a specific Resource Provider/Type:
```powershell
$ProviderNamespace = 'Microsoft.Network'
$ResourceTypeName = 'networkSecurityGroups'
((Get-AzResourceProvider -ProviderNamespace $ProviderNamespace).ResourceTypes | Where-Object ResourceTypeName -eq $ResourceTypeName).ApiVersions
```
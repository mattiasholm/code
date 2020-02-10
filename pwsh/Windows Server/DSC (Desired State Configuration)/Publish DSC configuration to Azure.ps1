<#
ALT 1:
Use VM Extension 'PowerShell Desired State Configuration' independently

- Add VM Extension 'PowerShell Desired State Configuration' from the Azure Portal
- Configuration Modules or Script: ZIP-file created in PowerShell below, e.g. "C:\Temp\Install-IIS.ps1.zip"
- Module-qualified Name of Configuration: [DscFileName]\[DscConfigurationName], e.g. Install-IIS.ps1\WebServer
- Version: [Latest version of DSC Extension], e.g. 2.76
- Auto Upgrade Minor Version: Yes
#>

$ConfigurationPath = 'C:\Users\MattiasHolm\Documents\GitHub\powershell\Windows Server\DSC (Desired State Configuration)\Install-IIS.ps1'
$OutputPath = 'C:\Temp'



$OutputArchivePath = Join-Path $OutputPath -ChildPath ((Split-Path -Path $ConfigurationPath -Leaf) + '.zip')
Publish-AzureRmVMDscConfiguration `
-ConfigurationPath $ConfigurationPath `
-OutputArchivePath $OutputArchivePath





<#
ALT 2:
Use Azure Automation (custom or Gallery)

- Add PS1 file directly as new Configuration in Azure Automation
- Compile the configuration file
- Connect VMs as DSC nodes
#>





<#
ALT 3:
Invoke LCM (Local Configuration Manager) locally with PowerShell:
Set-DSCLocalConfigurationManager
Start-DscConfiguration
#>





<#
OBS: En specifik nod kan endast ha en DSC-config, dvs. allt måste bakas in i en viss roll, snarare än modulärt.
Finns dock 'Partial Configurations' för detta ändamål, men i Azure Automation kan en viss nod fortfarande endast knytas till en DSC-config.

Om man assignar en ny DSC-config, slutar den gamla konfigurationen att appliceras, men den gamla konfigurationen tas ej bort automatiskt.
#>





# Verify DSC status locally with PowerShell:
Get-DscConfigurationStatus

# Verify applied DSC configuration locally with PowerShell:
Get-DscConfiguration


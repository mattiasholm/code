# Provide the SubscriptionId of the subscription where the ManagedDisk exists
$SourceSubscriptionId = "18acfa7a-785b-4c49-980d-b0ee07a7364a"

# Provide the name of the resource group where the ManagedDisk exists
$SourceResourceGroupName = "MigrateToCspTest"

# Provide the name of the ManagedDisk
$ManagedDiskName = "snowwebSrv0_WebSvrOSDisk"

# Login to an Azure account that has permission to access the ManagedDisk
Login-AzureRmAccount

# Set the context to the SubscriptionId where ManagedDisk exists
Select-AzureRmSubscription -SubscriptionId $SourceSubscriptionId

# Get the source ManagedDisk
$ManagedDisk= Get-AzureRMDisk -ResourceGroupName $SourceResourceGroupName -DiskName $ManagedDiskName

# Provide the SubscriptionId of the subscription where ManagedDisk will be copied to. If managed disk is copied to the same subscription then you can skip this step
$TargetSubscriptionId = "EC62605E-B21D-4A6D-B5A8-EEF1CFAD69E8"

# Name of the resource group where snapshot will be copied to
$TargetSubscriptionId = "SnowProduction"

# Set the context to the SubscriptionId where ManagedDisk will be copied to. If snapshot is copied to the same subscription then you can skip this step
Select-AzureRmSubscription -SubscriptionId $TargetSubscriptionId

$DiskConfig = New-AzureRmDiskConfig -SourceResourceId $ManagedDisk.Id -Location $ManagedDisk.Location -AccountType $ManagedDisk.AccountType -CreateOption Copy

# Create a new ManagedDisk in the target subscription and resource group
New-AzureRmDisk -Disk $DiskConfig -DiskName $ManagedDiskName -ResourceGroupName $TargetResourceGroupName
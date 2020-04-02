${ConnectionName} = ""
${ResourceGroupName} = ""
${IpsecPolicy} = New-AzIpsecPolicy `
    -IkeEncryption AES256 `
    -IkeIntegrity SHA256 `
    -DhGroup DHGroup14 `
    -IpsecEncryption AES256 `
    -IpsecIntegrity SHA256 `
    -PfsGroup PFS24 `
    -SALifeTimeSeconds 86400 `
    -SADataSizeKilobytes 102400000

Get-AzVirtualNetworkGatewayConnection -Name ${ConnectionName} -ResourceGroupName ${ResourceGroupName} | Set-AzVirtualNetworkGatewayConnection -IpsecPolicies $IpsecPolicy -Force
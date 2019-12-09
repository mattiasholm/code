$ws = New-WebServiceProxy 'http://wsmh.donator.se/wsmh/service.asmx?WSDL'



# Metod 'GetDistributionGroupMembers'

$dgm = $ws.GetDistributionGroupMembers("group123456@maklarhuset.se");
foreach ($Row in $dgm.Tables[0].Rows)
{ 
  Write-Host $($Row[1])
}



# Metod 'AddDistributionGroupMember'

$ws.AddDistributionGroupMember("group123456@maklarhuset.se", "user123456@maklarhuset.se");



# Metod 'RemoveDistributionGroupMember'

$ws.RemoveDistributionGroupMember("group123456@maklarhuset.se", "user123456@maklarhuset.se");






# Metod 'GetAllowSendToDistributionGroup'

$dgm = $ws.GetAllowSendToDistributionGroup("group123456@maklarhuset.se");
foreach ($Row in $dgm.Tables[0].Rows)
{ 
  write-host $($Row[0])
}



# Metod 'AddAllowSendToDistributionGroup'

$ws.AddAllowSendToDistributionGroup("group123456@maklarhuset.se", "user123456@maklarhuset.se");



# Metod 'RemoveAllowSendToDistributionGroup'

$ws.RemoveAllowSendToDistributionGroup("group123456@maklarhuset.se", "user123456@maklarhuset.se");
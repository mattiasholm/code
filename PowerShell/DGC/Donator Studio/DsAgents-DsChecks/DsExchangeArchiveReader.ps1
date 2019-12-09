#Create Table object
$table = New-Object system.Data.DataTable "tbl"
#Define Columns
$col1 = New-Object system.Data.DataColumn UPN,([string])
$col2 = New-Object system.Data.DataColumn Size,([string])
$col3 = New-Object system.Data.DataColumn Count,([string])
#Add the Columns
$table.columns.add($col1)
$table.columns.add($col2)
$table.columns.add($col3)


if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) 
{ 
    Add-PSSnapin Microsoft.Exchange.Management.* 
}

$Archives = Get-Mailbox -Archive


foreach ($Archive in $Archives) 
{
    $UserPrincipalName = $Archive.UserPrincipalName
    $TotalItemSize = ($Archive | Get-MailboxStatistics -Archive).TotalItemSize.value.ToMB()
    $TotalItems = ($Archive | Get-MailboxStatistics -Archive).ItemCount

    #Create a row
    $row = $table.NewRow()
    #Enter data in the row
    $row.UPN = $UserPrincipalName
    $row.Size = $TotalItemSize
    $row.Count = $TotalItems
    #Add the row to the table
    $table.Rows.Add($row)
}

$table.WriteXml("C:\DS\DsAgents\DsExchangeArchiveReader\XmlFiles\$(get-date -f yyyMMdd)_ExchangeArchive.xml")


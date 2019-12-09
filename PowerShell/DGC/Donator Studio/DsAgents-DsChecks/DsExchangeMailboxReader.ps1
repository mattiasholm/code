#Create Table object
$table = New-Object system.Data.DataTable “tbl”
#Define Columns
$col1 = New-Object system.Data.DataColumn ExchangeServer,([string])
$col2 = New-Object system.Data.DataColumn ExchangeVersion,([string])
$col3 = New-Object system.Data.DataColumn MailboxGuid,([string])
$col4 = New-Object system.Data.DataColumn DisplayName,([string])
$col5 = New-Object system.Data.DataColumn TotalItemSize,([int])
$col6 = New-Object system.Data.DataColumn ItemCount,([int])
$col7 = New-Object system.Data.DataColumn TotalDeletedItemSize,([int])
$col8 = New-Object system.Data.DataColumn StorageLimitStatus,([string])
$col9 = New-Object system.Data.DataColumn Database,([string])
#Add the Columns
$table.columns.add($col1)
$table.columns.add($col2)
$table.columns.add($col3)
$table.columns.add($col4)
$table.columns.add($col5)
$table.columns.add($col6)
$table.columns.add($col7)
$table.columns.add($col8)
$table.columns.add($col9)


if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) 
{ 
    Add-PSSnapin Microsoft.Exchange.Management.* 
}

$Mailboxes = Get-Mailbox -ResultSize unlimited

foreach ($Mailbox in $Mailboxes) 
{
    $ServerName = $Mailbox.ServerName
    $DatabaseName = $Mailbox.Database.Name
    $ExchangeGuid = $Mailbox.ExchangeGuid.Guid
    $DisplayName = $Mailbox.DisplayName
    $ExchangeVerMajor = $Mailbox.AdminDisplayVersion.Major

    $ExchangeVerFriendly = 'Unknown'

    if (15 -eq $ExchangeVerMajor)
    {
        $ExchangeVerFriendly =  '2013'
    }
    
    if (8 -eq $ExchangeVerMajor)
    {
        $ExchangeVerFriendly =  '2007'
    }

    $Mb_Stat = $Mailbox | Get-MailboxStatistics

    $ItemCount = $Mb_Stat.ItemCount
    if (!$ItemCount)
    {
        $ItemCount = 0
    }

    $TotalItemSize = $Mb_Stat.TotalItemSize
    if ($TotalItemSize)
    {
        $TotalItemSize = $Mb_Stat.TotalItemSize.value.ToMB()
    }
    else
    {
        $TotalItemSize = 0
    }

    $TotalDeletedItemSize = $Mb_Stat.TotalDeletedItemSize
    if ($TotalDeletedItemSize)
    {
        if ('Unlimited' -eq $TotalDeletedItemSize)
        {
            $TotalDeletedItemSize = 0
        }
        else
        {
            $TotalDeletedItemSize = $Mb_Stat.TotalDeletedItemSize.value.ToMB()
        }
    }
    else
    {
        $TotalDeletedItemSize = 0
    }

    $StorageLimitStatus =  $Mb_Stat.StorageLimitStatus
    if (!$StorageLimitStatus)
    {
        $StorageLimitStatus = ''
    }

    # We have items and Totala size in MB is 0, set to 1
    if (($ItemCount -gt 0) -and (0 -eq $TotalItemSize)) 
    {
        $TotalItemSize = 1
    }

    <#
    $DisplayName
    $ItemCount
    $TotalItemSize
    $TotalDeletedItemSize
    #>

    #Create a row
    $row = $table.NewRow()
    #Enter data in the row
    $row.ExchangeServer = $ServerName
    $row.ExchangeVersion = $ExchangeVerFriendly
    $row.MailboxGuid = $ExchangeGuid
    $row.DisplayName = $DisplayName
    $row.TotalItemSize = $TotalItemSize
    $row.ItemCount = $ItemCount
    $row.TotalDeletedItemSize = $TotalDeletedItemSize
    $row.StorageLimitStatus = $StorageLimitStatus
    $row.Database = $DatabaseName
    #Add the row to the table
    $table.Rows.Add($row)
  
}

$table.WriteXml("C:\DS\DsAgents\DsExchangeMailboxReader\XmlFiles\$(get-date -f yyyMMdd)_ExchangeMailbox.xml")


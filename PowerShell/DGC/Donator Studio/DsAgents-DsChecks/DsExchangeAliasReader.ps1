#Create Table object
$table = New-Object system.Data.DataTable “tbl”
#Define Columns
$col1 = New-Object system.Data.DataColumn MailboxGuid,([string])
$col2 = New-Object system.Data.DataColumn DisplayName,([string])
$col3 = New-Object system.Data.DataColumn AdressTyp,([string])
$col4 = New-Object system.Data.DataColumn Adress,([string])
$col5 = New-Object system.Data.DataColumn ArPrimar,([bool])
#Add the Columns
$table.columns.add($col1)
$table.columns.add($col2)
$table.columns.add($col3)
$table.columns.add($col4)
$table.columns.add($col5)


if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) 
{ 
    Add-PSSnapin Microsoft.Exchange.Management.* 
}

$Mailboxes = Get-Mailbox -ResultSize unlimited

foreach ($Mailbox in $Mailboxes) 
{
    $ExchangeGuid = $Mailbox.ExchangeGuid.Guid
    $DisplayName = $Mailbox.DisplayName
    $EmailAddresses = $Mailbox.EmailAddresses
    
    foreach ($EA in $EmailAddresses) 
    {
        $EA_Post = $EA.ToString().Split(':')

        if ($EA_Post[0] -ceq 'smtp')
        {
            #Create a row
            $row = $table.NewRow()
            #Enter data in the row
            $row.MailboxGuid = $ExchangeGuid
            $row.DisplayName = $DisplayName
            $row.AdressTyp = $EA_Post[0]
            $row.Adress = $EA_Post[1]
            $row.ArPrimar = $FALSE
            #Add the row to the table
            $table.Rows.Add($row)  
        }
        if ($EA_Post[0] -ceq 'SMTP') # ArPrimar
        {
            #Create a row
            $row = $table.NewRow()
            #Enter data in the row
            $row.MailboxGuid = $ExchangeGuid
            $row.DisplayName = $DisplayName
            $row.AdressTyp = $EA_Post[0]
            $row.Adress = $EA_Post[1]
            $row.ArPrimar = $TRUE
            #Add the row to the table
            $table.Rows.Add($row)  
        }
    }
    
}

$table.WriteXml("C:\DS\DsAgents\DsExchangeMailboxReader\XmlFiles\$(get-date -f yyyMMdd)_ExchangeAlias.xml")


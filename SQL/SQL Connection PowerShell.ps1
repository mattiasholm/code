$SQLServer = "b3studiotest.database.windows.net"
$SQLDBName = "B3StudioTest"
$uid ="sqladmin"
$pwd = Read-Host -Prompt 'Password'
$SqlQuery = "SELECT * from b3Roles;"



$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; User ID = $uid; Password = $pwd;"
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $SqlQuery
$SqlCmd.Connection = $SqlConnection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)

$DataSet.Tables[0] | out-file "C:\Temp\SqlOutput.csv"
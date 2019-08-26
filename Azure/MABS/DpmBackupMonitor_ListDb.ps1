$ConfigFile = ".\DpmBackupMonitor.json"
$Config = Get-Content -Path $ConfigFile | ConvertFrom-Json

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $($Config.SqlServer); Database = $($Config.SqlDatabase); Integrated Security = False; User ID = $($Config.SqlUserID); Password = $($Config.SqlPassword);"
$SqlConnection.Open()

$SqlQuery = "SELECT * FROM B3Care_Backup WHERE BackupTypeId = 2 OR BackupTypeId = 3"

$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.Connection = $SqlConnection
$SqlCmd.CommandText = $SqlQuery

$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd

$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$DataSet.Tables[0]

$SqlConnection.Close()
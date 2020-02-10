#!/usr/bin/env pwsh

$SqlServer = "b3studiotest.database.windows.net"
$SqlDBName = "B3StudioTest"
$UserName = "sqladmin"
$Password = Read-Host -Prompt 'Password' -AsSecureString



$Email = Read-Host -Prompt 'Email'
$SqlQuery = "SELECT IsAdministrator FROM hdUsers WHERE Email = '$Email'"
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $SqlServer; Database = $SqlDBName; User ID = $UserName; Password = $([System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)));"
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $SqlQuery
$SqlCmd.Connection = $SqlConnection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)

$IsAdministrator = $DataSet.Tables.IsAdministrator

if ($IsAdministrator -eq $true) {
    Write-Host -ForegroundColor Green -Object "Access Granted for user $Email"
}
elseif ($IsAdministrator -eq $false) {
    Write-Host -ForegroundColor Red -Object "Access Denied for user $Email"
}
elseif ($IsAdministrator -eq $null) {
    Write-Host -ForegroundColor Red -Object "Could not find user $Email"
}
$ConfigFile = ".\DpmBackupMonitor.json"
$Config = Get-Content -Path $ConfigFile | ConvertFrom-Json



$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $($Config.SqlServer); Database = $($Config.SqlDatabase); Integrated Security = False; User ID = $($Config.SqlUserID); Password = $($Config.SqlPassword);"
$SqlConnection.Open()

$SqlQuery = "IF EXISTS(SELECT ID FROM B3Care_Backup WHERE (ServerName = @ServerName) AND (BackupName = @BackupName) AND (BackupTypeID = @BackupTypeID)) `
            UPDATE B3Care_Backup SET LastBackupSize = @LastBackupSize, LastFullBackupDate = @LastFullBackupDate WHERE (ServerName = @ServerName) AND (BackupName = @BackupName) AND (BackupTypeID = @BackupTypeID) `
            ELSE `
            INSERT INTO B3Care_Backup (BackupTypeID, ServerName, BackupName, LastBackupSize, LastFullBackupDate) VALUES (@BackupTypeID, @ServerName, @BackupName, @LastBackupSize, @LastFullBackupDate)"

$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.Connection = $SqlConnection
$SqlCmd.CommandText = $SqlQuery



$DataSources = Get-DPMDatasource -DPMServerName $Config.DpmServer | Where-Object { $_.Protected -eq $true }

foreach ($DataSource in $DataSources) {

    $RecoveryPoints = @()
    $RecoveryPoints += Get-RecoveryPoint -Datasource $DataSource | Sort-Object -Property BackupTime -Descending | Select-Object -First 1
    $RecoveryPoints += Get-RecoveryPoint -Datasource $DataSource -Online | Sort-Object -Property BackupTime -Descending | Select-Object -First 1
    
    if (!($RecoveryPoints)) {
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@BackupTypeID", $null)
        $SqlCmd.Parameters.AddWithValue("@LastBackupSize", $null)
        $SqlCmd.Parameters.AddWithValue("@ServerName", $DataSource.Computer)
        $SqlCmd.Parameters.AddWithValue("@BackupName", $DataSource.Name)
        $SqlCmd.Parameters.AddWithValue("@LastFullBackupDate", $null)

        $SqlCmd.ExecuteNonQuery()
    }

    foreach ($RecoveryPoint in $RecoveryPoints) {

        switch ($RecoveryPoint.Location) {
            'Disk' { $BackupTypeID = 2 }
            'Cloud' { $BackupTypeID = 3 }
            default { $BackupTypeID = 999 }
        }

        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@BackupTypeID", $BackupTypeID)
        $SqlCmd.Parameters.AddWithValue("@LastBackupSize", ([Math]::Round(($RecoveryPoint.Size) / 1MB, 2)))
        $SqlCmd.Parameters.AddWithValue("@ServerName", $DataSource.Computer)
        $SqlCmd.Parameters.AddWithValue("@BackupName", $DataSource.Name)
        $SqlCmd.Parameters.AddWithValue("@LastFullBackupDate", $RecoveryPoint.BackupTime)

        $SqlCmd.ExecuteNonQuery()
    }
}

$SqlConnection.Close()
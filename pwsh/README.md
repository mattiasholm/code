# Cheat Sheet - PowerShell

<br>

## Test connection to SQL database:

```pwsh
$connectionString = ""
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $connectionString
$sqlConnection.Open()

$sqlConnection

$sqlConnection.Close()
```
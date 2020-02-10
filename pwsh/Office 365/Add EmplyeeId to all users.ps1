$CsvFile = "/home/admin/EmployeeId.csv"

$ErrorActionPreference = 'SilentlyContinue'
$LogFile = New-Item -Name EmployeeId.log -Path $(Split-Path -Path $CsvFile -Parent) -Force
$Users = Import-Csv -Path $CsvFile

foreach ($User in $Users) {
    $ObjectId = (Get-AzADUser -UserPrincipalName $User.UserPrincipalName).Id

    if ($ObjectId) {
        Set-AzureADUserExtension -ObjectId $ObjectId -ExtensionName employeeId -ExtensionValue $User.EmployeeId

        if ((Get-AzureADUser -ObjectId $User.UserPrincipalName).ExtensionProperty.employeeId -eq $User.EmployeeId) {
            "SUCCESS `t User {0} was updated with employee ID {1}" -f $User.UserPrincipalName, $User.EmployeeId | Out-File -FilePath $LogFile -Append
        }
        else {
            "WARNING `t User {0} could not be updated" -f $User.UserPrincipalName | Out-File -FilePath $LogFile -Append
        }
    }
    else {
        "ERROR `t`t User {0} not found" -f $User.UserPrincipalName | Out-File -FilePath $LogFile -Append
    }
}
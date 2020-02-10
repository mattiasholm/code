$OneDriveFolder = Get-ChildItem "\\tsclient\C\Users\$env:USERNAME\OneDrive - *"
#$OneDriveFolder = Get-ChildItem "$env:USERPROFILE\OneDrive - *"

if ($OneDriveFolder)
{
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Links\OneDrive - B3IT Management AB.lnk")
    $Shortcut.TargetPath = "$OneDriveFolder"
    $Shortcut.Save()
}
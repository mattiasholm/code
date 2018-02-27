$OneDriveFolder = Get-ChildItem "\\tsclient\C\Users\$env:USERNAME\OneDrive - *"
#$OneDriveFolder = Get-ChildItem "$env:USERPROFILE\OneDrive - *"

if ($OneDriveFolder)
{
    $o = New-Object -ComObject shell.application                                                                                   
    $o.NameSpace($OneDriveFolder.FullName).Self.InvokeVerb("pintohome")
}
Function Add-OneDriveSecondaryAdmin($AdminURL,$SecondaryAdmin)
{
    #connect Spo service.
    Connect-SPOService -Url $AdminURL
    #Get all OneDrive URL's.
    $OneDriveURLs = Get-SPOSite -IncludePersonalSite $true -Limit All -Filter "Url -like '-my.sharepoint.com/personal/'"
    foreach($OneDriveURL in $OneDriveURLs)
    {
        #Add Secondary administrator to OneDrive Site.
        Set-SPOUser -Site $OneDriveURL.URL -LoginName $SecondaryAdmin -IsSiteCollectionAdmin $True -ErrorAction SilentlyContinue
        Write-Host "Added secondary admin to the site $($OneDriveURL.URL)" 
    }
}
Add-OneDriveSecondaryAdmin -SecondaryAdmin "admin.mattias.holm@b3.se" -AdminURL "https://b3it-admin.sharepoint.com"





Function Remove-OneDriveSecondaryAdmin($AdminURL,$SecondaryAdmin)
{
    #connect Spo service.
    Connect-SPOService -Url $AdminURL
    #Get all OneDrive URL's.
    $OneDriveURLs = Get-SPOSite -IncludePersonalSite $true -Limit All -Filter "Url -like '-my.sharepoint.com/personal/'"
    foreach($OneDriveURL in $OneDriveURLs)
    {
        #Add Secondary administrator to OneDrive Site.
        Set-SPOUser -Site $OneDriveURL.URL -LoginName $SecondaryAdmin -IsSiteCollectionAdmin $false -ErrorAction SilentlyContinue
        Write-Host "Removed secondary admin to the site $($OneDriveURL.URL)" 
    }
}
Remove-OneDriveSecondaryAdmin -SecondaryAdmin "admin.erik.lundgren@b3.se" -AdminURL "https://b3it-admin.sharepoint.com"
Remove-OneDriveSecondaryAdmin -SecondaryAdmin "admin.sandra.kopp@b3.se" -AdminURL "https://b3it-admin.sharepoint.com"
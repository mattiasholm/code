#!/usr/bin/env pwsh

Set-PSRepository PSGallery -InstallationPolicy Trusted

Install-Module Az -Confirm:$false -Force
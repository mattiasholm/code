#!/usr/bin/env pwsh

Set-PSRepository PSGallery -InstallationPolicy Trusted

Get-Module -All | Update-Module -Confirm:$false -Force -ErrorAction "SilentlyContinue"
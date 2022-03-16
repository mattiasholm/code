#!/usr/bin/env pwsh

$Config = Get-Content main.config
$Module = ($Config | Select-String 'module=').ToString().Replace('module=', '').Replace("'", '')
$Template = ($Config | Select-String 'template=').ToString().Replace('template=', '').Replace("'", '')

Import-Module -FullyQualifiedName $Module
Test-AzTemplate -MainTemplateFile $Template -TemplatePath $Template

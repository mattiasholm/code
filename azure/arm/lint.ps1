#!/usr/bin/env pwsh

$Module = './arm-ttk/arm-ttk/arm-ttk.psd1'
$TemplateFile = 'main.json'

Import-Module -FullyQualifiedName $Module
Test-AzTemplate -MainTemplateFile $TemplateFile -TemplatePath $TemplateFile

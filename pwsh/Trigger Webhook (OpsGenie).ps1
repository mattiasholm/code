#!/usr/bin/env pwsh

<#
.SYNOPSIS
  <Overview of script>
.DESCRIPTION
  <Brief description of script>
.PARAMETER <Parameter_Name>
    <Brief description of parameter input required. Repeat this attribute if required>
.INPUTS
  <Inputs if any, otherwise state None>
.OUTPUTS
  <Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>
.NOTES
  Version:        1.0
  Author:         <Name>
  Creation Date:  <Date>
  Purpose/Change: Initial script development
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
#>





<# GAMMAL SKRIPTINFO, FLYTTA UPP TILL COMMENT-BASED HELP OVAN!
# Author: Mattias Holm
# GitHub: https://github.com/mattiasholm
# 
# Description: Trigger webhook and send JSON payload
# Disclaimer: Please run this script at your own risk. I take no personal responsibility whatsoever should it fail you or wreak havoc amongst your environment.
#>


$WebhookUrl = "https://api.opsgenie.com/v1/json/azure?apiKey=d9df92f1-a024-4bb9-a251-099b63838f3e"

$body = @{
  condition_window_size = "5"
  condition_threshold   = "1"
}

ConvertTo-Json $body




$JsonData = @"
{
  "_incomingData": {
    "_parsedData": {
      "condition_window_size": "5",
      "condition_threshold": "1",
      "condition_time_aggregation": "Average",
      "alertSource": "Azure[Azure - Donald Duck Ltd - Critical - SLA Platinum-Create Alert] with incomingDataId[37b54d5c-55d1-4d78-8865-0dada609f24c] using policy/policies[OverwriteQuietHours]",
      "condition_operator": "GreaterThan",
      "condition_type": "Metric",
      "resource_type": "microsoft.web/serverfarms",
      "description": "",
      "resource_group_name": "B3Studio",
      "condition_metric_name": "CPU Percentage",
      "subscription_id": "18acfa7a-785b-4c49-980d-b0ee07a7364a",
      "portal_link": "https://portal.azure.com/#resource/subscriptions/18acfa7a-785b-4c49-980d-b0ee07a7364a/resourceGroups/B3Studio/providers/Microsoft.Web/serverfarms/B3StudioTestPlan",
      "condition_metric_unit": "Percent",
      "delayIfDoesNotExists": "true",
      "name": "Test OpGenie",
      "condition_metric_value": "4.2",
      "resource_id": "/subscriptions/18acfa7a-785b-4c49-980d-b0ee07a7364a/resourceGroups/B3Studio/providers/Microsoft.Web/serverfarms/B3StudioTestPlan",
      "id": "/subscriptions/18acfa7a-785b-4c49-980d-b0ee07a7364a/resourceGroups/B3Studio/providers/microsoft.insights/alertrules/Test%20OpGenie",
      "resource_name": "b3studiotestplan",
      "resource_region": "West Europe",
      "timestamp": "2017-10-23T11:12:48.1764118Z",
      "status": "Activated"
    },
    "integrationType": "Azure",
    "integrationName": "Azure - Donald Duck Ltd - Critical - SLA Platinum",
    "incomingDataId": "37b54d5c-55d1-4d78-8865-0dada609f24c"
  },
  "_result": {
    "alertMessage": "[Azure] CPU Percentage GreaterThan 1 Metric in the last 5 mins was activated for sites: West Europe/b3studiotestplan",
    "alertAction": "Create",
    "integrationName": "Azure - Donald Duck Ltd - Critical - SLA Platinum",
    "alertCount": "1",
    "integrationActionName": "Create Alert",
    "alertId": "92baa14f-62fb-4bed-b438-1a26cac69fbe",
    "alertAlias": "/subscriptions/18acfa7a-785b-4c49-980d-b0ee07a7364a/resourceGroups/B3Studio/providers/microsoft.insights/alertrules/Test%20OpGenie - /subscriptions/18acfa7a-785b-4c49-980d-b0ee07a7364a/resourceGroups/B3Studio/providers/Microsoft.Web/serverfarms/B3StudioTestPlan",
    "user": "Azure"
  }
}
"@

# SKAPA EN AZURE-TRIGGERED ALERT OCH TITTA DÄREFTER PÅ JSON RAW FÖR ATT SKAPA CUSTOM ALERT!

Invoke-RestMethod -Method Post -Uri $WebhookUrl -Body $JsonData
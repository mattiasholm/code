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






# Author: Mattias Holm
# GitHub: https://github.com/mattiasholm
# 
# Description: Trigger webhook and send JSON payload
# Disclaimer: Please run this script at your own risk. I take no personal responsibility whatsoever should it fail you or wreak havoc amongst your environment.



$WebhookUrl = "https://api.opsgenie.com/v1/json/azure?apiKey=d9df92f1-a024-4bb9-a251-099b63838f3e"
$JsonData = ""


{
    "_incomingData": {
      "_parsedData": {
        "condition_window_size": "null",
        "condition_threshold": "null",
        "condition_time_aggregation": "null",
        "condition_operator": "null",
        "condition_type": "null",
        "resource_type": "null",
        "description": "null",
        "resource_group_name": "null",
        "condition_metric_name": "null",
        "subscription_id": "null",
        "portal_link": "null",
        "condition_metric_unit": "null",
        "delayIfDoesNotExists": "true",
        "name": "null",
        "condition_metric_value": "null",
        "resource_id": "null",
        "id": "null",
        "resource_name": "null",
        "resource_region": "null",
        "timestamp": "null",
        "status": "null"
      },
      "integrationType": "Azure",
      "integrationName": "Azure - Donald Duck Ltd - Critical - SLA Platinum",
      "incomingDataId": "148f2ef0-143b-4780-a127-197d33187ba9"
    }
  }


# SKAPA EN AZURE-TRIGGERED ALERT OCH TITTA DÄREFTER PÅ JSON RAW FÖR ATT SKAPA CUSTOM ALERT!

Invoke-RestMethod -Method Post -Uri $WebhookUrl -Body $JsonData
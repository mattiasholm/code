$DomainName = ".dk"



Get-WebBinding | Where-Object {$_.bindingInformation -like "*$DomainName*"}  | % {
    $name = $_.ItemXPath -replace '(?:.*?)name=''([^'']*)(?:.*)', '$1'
    New-Object psobject -Property @{
        Name = $name
        Binding = $_.bindinginformation.Split(":")[-1]
    }
} | Group-Object -Property Name | 
Format-Table Name, @{n="Bindings";e={$_.Group.Binding -join "`n"}} -Wrap



### OBS: Finns även PSProvider för IIS:
Get-ChildItem IIS:\Sites
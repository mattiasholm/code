$Name = 'B3 Göteborg'
$IpAddress = '10.0.60.254'
$PrinterDriver = 'PCL6 V4 Driver for Universal Print'



if (!(Get-Printer | Where-Object { $_.PortName -eq (Get-PrinterPort | Where-Object { $_.PrinterHostAddress -eq $IpAddress }).Name })) {

    if (!(Get-PrinterPort | Where-Object { $_.PrinterHostAddress -eq $IpAddress })) {  
        Add-PrinterPort -Name $IpAddress -PrinterHostAddress $IpAddress
    }

    if (!(Get-PrinterDriver | Where-Object { $_.Name -eq $PrinterDriver })) {  
        Add-PrinterDriver -Name $PrinterDriver
    }

    Add-Printer -Name $Name -PortName (Get-PrinterPort | Where-Object { $_.PrinterHostAddress -eq $IpAddress }).Name -DriverName $PrinterDriver
}
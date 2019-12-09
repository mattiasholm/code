#Sätter rättighter på kataloger
    $acl = Get-Acl $sitepath
    $isProtected = $false 
    $preserveInheritance = $true 
    $acl.SetAccessRuleProtection($isProtected, $preserveInheritance)
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$kund","Modify", "ContainerInherit, ObjectInherit", "None", "Allow")
    $acl.AddAccessRule($rule)
    Set-Acl $sitepath $acl 
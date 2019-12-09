# Skapa RoleGroup:
New-RoleGroup -Description "Meritmind Manage Distribution Groups" -DisplayName "Meritmind Manage Distribution Groups" -Name "Meritmind Manage Distribution Groups" 

# Lägg till medlemmar till RoleGroup:
Add-RoleGroupMember "Meritmind Manage Distribution Groups" -Member "CN=ssladmin,OU=Meritmind,OU=Hosting,DC=emcat,DC=com"
Add-RoleGroupMember "Meritmind Manage Distribution Groups" -Member "CN=Meritmind Reception,OU=Meritmind,OU=Hosting,DC=emcat,DC=com"
Add-RoleGroupMember "Meritmind Manage Distribution Groups" -Member "CN=IT Meritmind,OU=Meritmind,OU=Hosting,DC=emcat,DC=com"
Add-RoleGroupMember "Meritmind Manage Distribution Groups" -Member "CN=Peter Haglund,OU=Meritmind,OU=Hosting,DC=emcat,DC=com"
Add-RoleGroupMember "Meritmind Manage Distribution Groups" -Member "CN=Nathalié Jonsson,OU=Meritmind,OU=Hosting,DC=emcat,DC=com"

# Skapa en ny ManagementRoleAssignment:
New-ManagementRoleAssignment -Role "Security Group Creation and Membership" -RecipientOrganizationalUnitScope emcat.com/Hosting/Meritmind -Name "Meritmind Manage Distribution Groups" -SecurityGroup "Meritmind Manage Distribution Groups"
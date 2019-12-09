$Searcher = New-Object DirectoryServices.DirectorySearcher
$Searcher.Filter = '(objectClass=user)'
$Searcher.SearchRoot = 'LDAP://DC=emcat,DC=com'
$Users = $Searcher.FindAll().Properties.userprincipalname


$Domains = $Users -replace ".*@","" | select -Unique | Sort-Object
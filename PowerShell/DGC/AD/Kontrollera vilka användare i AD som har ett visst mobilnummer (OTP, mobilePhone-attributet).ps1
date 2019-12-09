$MobilePhone = "+46707800740"



(Get-ADUser -Properties * -Filter {MobilePhone -eq $MobilePhone}).DisplayName
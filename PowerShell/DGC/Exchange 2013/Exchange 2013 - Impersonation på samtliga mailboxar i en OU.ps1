# OBS: Körs endast en gång:
New-ManagementScope -Name "Maklarhuset" -RecipientRoot "emcat.com/Hosting/Maklarhuset" -RecipientRestrictionFilter {RecipientType -eq "UserMailbox"}

New-ManagementRoleAssignment –Name:Maklarhuset –Role:ApplicationImpersonation –User:ews.svc2013 –CustomRecipientWriteScope:Maklarhuset



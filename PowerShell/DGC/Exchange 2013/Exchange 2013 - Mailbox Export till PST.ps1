Add-MailboxPermission -Identity "Peter Thuresson" -User qwe46 -AccessRights FullAccess
New-ManagementRoleAssignment –Role "Mailbox Import Export" –User qwe46

New-MailboxExportRequest -Mailbox "Peter Thuresson" -FilePath \\don-mgt3\PST\peter.thuresson.pst
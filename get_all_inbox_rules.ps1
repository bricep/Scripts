$users = (get-mailbox -resultsize unlimited).UserPrincipalName 
foreach ($user in $users) 
{
Get-InboxRule -Mailbox $user | Select-Object MailboxOwnerID,Name,Description,Enabled,RedirectTo, MoveToFolder,ForwardTo | Export-CSV C:\Scripts\testing.csv -NoTypeInformation -Append
}

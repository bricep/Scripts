#
#Powershell one-liners I use A LOT. Some are useful for RMMs, some for Office365 / Azure Powershell
#
search-adaccount -accountinactive -usersonly -timespan "195" | Export-Csv C:\Users\admin\Desktop\Oldusers.csv 
#
#Stop ScheduledTasks With Name Like 
Get-ScheduledTask | where {$_.taskname -like "Optimize Start Menu Cache Files*"} | Unregister-ScheduledTask -Confirm:$false

#Get Services That Are Stopped That Should be Auto 
GWMI win32_service -Filter "startmode = 'auto' AND state != 'running'"  | select DisplayName, Name, StartMode, State, ExitCode | ft -auto

#Remove Candy Crush (Or other Windows apps) 
Get-AppxPackage *CandyCrush* | Remove-AppxPackage

#Test for .Net 4.5
(Get-ItemProperty -Path 'HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full' -ErrorAction SilentlyContinue).Version -like '4.5*' 

#Get AD Users and Info
Get-ADUser -Filter * -Properties * | select GivenName,Surname,Title,Office,{(Get-AdUser $_.Manager -Properties DisplayName).DisplayName},telephoneNumber | export-csv -path C:\Csv\employees.csv 
#Delete Phishing Email (Example - Tweak for Specific Instances)
Get-mailbox -ResultSize unlimited | Search-Mailbox -SearchQuery 'Subject:"open remittance" AND Received:07-16-2018 AND from:nicole@x.com' -TargetMailbox "spam" -TargetFolder "7-16-2018 Remittance Removal" -LogLevel Full -Confirm 
#Add Calendar Permissions
Add-MailboxFolderPermission -Identity user1@domain.com:\calendar -user user2@domain.com -AccessRights Editor

#Generate a list of mailbox sizes
get-mailbox | get-mailboxstatistics | select DisplayName,ItemCount,TotalItemSize | export-csv "MailboxSizes.csv"

#Get list of installed printers
get-WmiObject -class Win32_printer | ft name, systemName, shareName

#Find What Mailboxes Have Access to Other / Which Mailboxes
Get-Mailbox | Get-MailboxPermission | where {$_.user.tostring() -ne "NT AUTHORITYSELF" -and $_.IsInherited -eq $false} | Select Identity,User,@{Name='Access Rights';Expression={[string]::join(', ', $_.AccessRights)}} | Export-Csv -NoTypeInformation mailboxpermissions.csv 
#Find Files Larger Than X
Get-ChildItem C:\ -recurse | where-object {$_.length -gt 524288000} | Sort-Object length | ft fullname, length -auto

#Find Files Larger Than X Of a Specific Type
Get-ChildItem C:\ -recurse -include *.exe | where-object {$_.length -gt 524288000} | Sort-Object length | ft fullname, length -auto
#Get Uninstall String / GUID in Registry (Example uses Quicktime 7)
$qtVer = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall  | 
    Get-ItemProperty | 
        Where-Object {$_.DisplayName -eq "Quicktime 7" } | 
            Select-Object -Property DisplayName, UninstallString
#Event Viewer Searches
Get-Eventlog System -Newest 100 | Where-Object {$_.entryType -Match "Error"} | ft -AutoSize 
Get-Eventlog Application -Newest 100 | Where-Object {$_.entryType -Match "Error"} | ft -AutoSize 
#Search Admin Audit Log with Powershell
Search-AdminAuditLog -StartDate "4/6/2015 12:00:00 AM" -EndDate 4/6/2015 11:20:00 AM" 
#Find what distribution lists a user belongs to 
$Mailbox=get-Mailbox user@domain.com 
$DN=$mailbox.DistinguishedName 
$Filter = "Members -like ""$DN""" 
Get-DistributionGroup -ResultSize Unlimited -Filter $Filter
#Add and Remove Distribution Group Members in Office365
Add-DistributionGroupMember -Identity "DistributionGroupName" -Member wcoyote 
//full email address not needed 
Remove-DistributionGroupMember -Identity "DistributionGroupName" -Member wcoyote  
//full email address not needed

#Create a Shared Mailbox and Grant Send On Behalf and Permissions
New-Mailbox -Shared -Name "Sales Department" -DisplayName "Sales Department" -Alias Sales | Set-Mailbox -GrantSendOnBehalfTo MarketingSG | Add-MailboxPermission -User MarketingSG -AccessRights FullAccess -InheritanceType All 

#Change Service Logon Type | https://stackoverflow.com/questions/966389/how-to-change-user-credentials-of-windows-service-from-command-line
sc.exe config MyService obj= localsystem
sc.exe config "Service Name" obj= "DOMAIN\User" password= "password"

#Changing Email Address of Office365 Group 
Set-UnifiedGroup -Identity "Marketing Department" -PrimarySmtpAddress marketing@contoso.com
#Add additional addresses of Office365 Group: 
Set-UnifiedGroup -Identity "Marketing Department" -emailaddresses smtp:alias1@contos.com

#Import List of Firewall IPs, use from http://www.nirsoft.net/countryip/index.html
#List in form of n the form of 1.1.1.1/24 or 1.1.1.1-1.1.1.255 
Import-Firewall-Blocklist.ps1 -rulename BlockCountry -inputfile Country-BlockList 

#Two ways of getting mailbox sizes
get-mailbox | get-mailboxstatistics | select DisplayName,ItemCount,TotalItemSize | export-csv "MailboxSizes.csv" 
Get-Mailbox | Get-MailboxStatistics | Select-Object DisplayName, IsArchiveMailbox, ItemCount, TotalItemSize | Format-Table –autosize 

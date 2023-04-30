#These are checks from several years ago that Rackspace used to determine whether a reboot / update caused issues
#PRE 
Import-Module ServerManager; New-Item C:\checks\180517-00496 -type directory -force; Function Pre-Checks { ipconfig /all | ft -AutoSize | Out-String; "list volume","list disk" | diskpart | Out-String; Get-Service | ft -auto | Out-String; Get-WindowsFeature | where-object {$_.Installed -eq $True}; Get-WmiObject Win32_Share | ft -AutoSize | Out-String } Pre-Checks | Out-File C:\checks\180517-00496\pre-checks.txt 
 
#POST 
Import-Module ServerManager; Function Post-Checks { ipconfig /all | ft -AutoSize | Out-String; "list volume","list disk" | diskpart | Out-String; Get-Service | ft -auto | Out-String; Get-WindowsFeature | where-object {$_.Installed -eq $True}; Get-WmiObject Win32_Share | ft -AutoSize | Out-String } Post-Checks | Out-File C:\checks\180517-00496\post-checks.txt 
 
#COMPARE 
#Compare-Object -referenceobject $(get-content C:\checks\180517-00496\pre-checks.txt) -differenceobject $(get-content C:\checks\180517-00496\post-checks.txt) | ft -AutoSize | Out-File C:\checks\180517-00496\compare-checks.txt; Invoke-Item C:\checks\180517-00496\compare-checks.txt 
 
#Review automatic services that are not running after the reboot and take actions as required.  
GWMI win32_service -Filter "startmode = 'auto' AND state != 'running'"  | select DisplayName, Name, StartMode, State, ExitCode | ft -auto

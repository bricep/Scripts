$user = Get-WmiObject -Class win32_computersystem | % Username
Start-Process powershell.exe -Credential $user
$registryPath = 'HKCU:\Software\Policies\Microsoft\office\16.0\outlook'
$Name = 'DisableAntiSpam'
$value = "1"

IF(!(Test-Path $registryPath))

  {
    Write-Output "Registry path does not exist, creating path"
    New-Item -Path $registryPath -Force | Out-Null
    Write-Output "Setting property to 0"
    New-ItemProperty -Path $registryPath -Name $name -Value $value -Type DWORD -Force | Out-Null}

 ELSE {
    Write-Output "Registry path exists, setting property to 0"
    Set-ItemProperty -Path $registryPath -Name $name -Value $value -Type DWORD -Force | Out-Null}
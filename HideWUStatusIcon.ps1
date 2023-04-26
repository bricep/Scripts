$registryPath = 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings'
$Name = 'TrayIconVisibility'
$value = "0"

IF(!(Test-Path $registryPath))

  {
    Write-Output "Registry path does not exist, creating path"
    New-Item -Path $registryPath -Force | Out-Null
    Write-Output "Setting property to 0"
    New-ItemProperty -Path $registryPath -Name $name -Value $value -Type DWORD -Force | Out-Null}

 ELSE {
    Write-Output "Registry path exists, setting property to 0"
    Set-ItemProperty -Path $registryPath -Name $name -Value $value -Type DWORD -Force | Out-Null}
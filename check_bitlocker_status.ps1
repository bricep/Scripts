$bit = Get-BitLockerVolume

if ($bit.ProtectionStatus -eq 'On'){
    Write-Host 'Bitlocker Enabled - VolumeStatus is' $bit.VolumeStatus
}
Else {
    Write-Host 'BitLocker Disabled'
    exit 0
}
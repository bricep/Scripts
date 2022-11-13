#requires -version 2
<#
.SYNOPSIS
  Gets network drives on a machine
#>
#---------------------------------------------------------[Initialisations]--------------------------------------------------------
Set-StrictMode -Version 'Latest'
$ErrorActionPreference = 'Stop'

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#-----------------------------------------------------------[Functions]------------------------------------------------------------
Function Get-NetworkDrives {
    Get-SMBMapping | Select-Object LocalPath, RemotePath | Write-Host
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------
Get-NetworkDrives
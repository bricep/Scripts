$softwares=@('Outlook Assistant MAPI64 Helper','Outlook Assistant','Outlook Assistant sklquery helper')
ForEach ($software in $softwares) {
$guids = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall  |
    Get-ItemProperty |
        Where-Object {$_.DisplayName -eq $software } |
            Select-Object -Property DisplayName, UninstallString
	        	
	            ForEach ($guid in $guids) {

                If ($guid.UninstallString) {
                    Write-Host "Uninstalling $software with $guid.uninstallstring"
                    $uninst = $guid.UninstallString
                    $uninst = $uninst -replace "/I", "/x "
                    Start-Process cmd -ArgumentList "/c $uninst /quiet /norestart" -NoNewWindow
    }
    else {
        Write-Host "Not found"
    }
    }
}
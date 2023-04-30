#Find Subfolders of a Share With No Files Newer then a Year 
$shareName = "\\server\share"
# Don't -recurse, just grab top-level directories 
$directories = Get-ChildItem -Path $shareName | Where-Object { $_.psIsContainer -eq $true } 
ForEach ( $d in $directories ) {  
    # Get any non-container children written in the past year 
    $recentWrites = Get-ChildItem $d.FullName -recurse | Where-Object { $_.psIsContainer -eq $false -and $_.LastWriteTime -gt $(Get-Date).AddYears(-1) }  
    If ( -not $recentWrites ) { 
        $d.FullName 
    } 
} 

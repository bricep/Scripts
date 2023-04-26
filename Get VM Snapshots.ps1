$results=get-vmsnapshot -vmname * | Select VMName, Name, CreationTime
$count=$results | measure | Select Count
If ($count.Count -eq 0) 
	{Write-Host "No snapshots found"
	Exit 0}
Else {Write-Host $results.VMName 'has' $count.Count 'snapshots'
Exit 1001}
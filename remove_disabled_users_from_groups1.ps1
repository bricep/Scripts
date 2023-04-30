import-module activedirectory  
$users=get-aduser -filter 'enabled -eq $false' -searchbase "DC=contoso,DC=com" -Properties samaccountname,memberof  |select samaccountname, @{n=’MemberOf’; e= { ( $_.memberof | % { (Get-ADObject $_).Name }) -join “,” }}   
#set description  
Foreach ($user in $users)
{Set-ADUser $user.samaccountname -Description "Was a member of :- $($user.memberof)"
# Remove From all the Groups
Get-ADGroup -Filter {name -notlike "*domain users*"}  | Remove-ADGroupMember -Members $user.samaccountname -Confirm:$False
}  
$total = ($users).count   
Write-Host "$total accounts have been processed..." -ForegroundColor Green 

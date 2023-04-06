get-messagetrackinglog -start "11/29/2017 12:00am" -resultsize 3000| where {[string]$_.recipients -like "*@domain.com*"} 

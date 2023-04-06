gci -path c:\ -recurse -include *.pst -erroraction 'silentlycontinue'|select-object fullname,l 

astwritetime | fl fullname 

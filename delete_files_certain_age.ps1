Get-ChildItem "C:\temp" -Recurse -File | Where CreationTime -lt  (Get-Date).AddDays(-15)  | Remove-Item -Force 

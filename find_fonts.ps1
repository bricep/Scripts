#Find fonts in an array on a machine to tell if they are installed. We used this in our RMM before pushing a font installer
$GciFiles = Get-Childitem C:\Windows\Fonts -Force 

#$GciFiles | Sort-Object | FT Name 
foreach ($font in $GciFiles) { 

  If ($font.Name -EQ "BASKVILL.ttf") {Write-Host “Baskerville is present”} 

  If ($font.Name -EQ "*GillSansNova-Light.otf*") {Write-Host “Gill Sans Nova Light is present”} 

  If ($font.Name -EQ "*GillSansNova-LightItalic.otf*") {Write-Host “Gill Sans Nova Light Italic is present”} 

  If ($font.Name -EQ "*GillSansNova-Medium.otf*") {Write-Host “Gill Sans Nova Medium is present”} 

  If ($font.Name -EQ "*GillSansNova-MediumItalic.otf*") {Write-Host “Gill Sans Nova Medium Italic is present”} 

  If ($font.Name -EQ "*GillSansNova-UltraLight.otf*") {Write-Host “Gill Sans Nova Ultra Light is present”} 

#else {Write-Host “Nope”} 
else {Continue} 
} 
Write-Host "Script has finished running" 

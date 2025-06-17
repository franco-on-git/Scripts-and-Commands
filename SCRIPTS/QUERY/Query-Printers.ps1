# If Printer EXISTS
$Printers = get-printer | Where-Object {$_.name -notlike "*xps*" -and $_.Name -notlike "*pdf*"}

if ($null -ne $Printers) {Write-Host "Printer Mappings Found"}
Else {Write-Host "No Printers"}

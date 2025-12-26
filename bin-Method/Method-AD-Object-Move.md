
```powershell

$ouTarget = 'OU=CCTV Servers,OU=Servers,DC=safeway01,DC=ad,DC=safeway,DC=com'

Write-Host "Enter Server Name:" -FregroundColor Yellow
$moveme = Read-Host

write-host ""
write-host "Current location..." -ForegroundColor Yellow
(Get-ADComputer $moveme).distinguishedname

write-host ""
write-host "Moving server to new location.." -ForegroundColor Yellow
Start-Sleep 3
# Example....
Get-ADComputer $moveme | Move-ADObject -TargetPath $ouTarget

Write-Host ""
Write-Host "New location..." -ForegroundColor Yellow
(Get-ADComputer $moveme).distinguishedname
```
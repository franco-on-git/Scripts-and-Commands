# Event Viwer Logs Export



> [!NOTE]
> - Export SYSTEM and APPLICATIOn logs to user desktop.

> [!WARNING]
> - **<ins>Administrator</ins> Terminal required!**

```powershell
Clear-Host

$ExportDir = "$HOME\Desktop\EventLogs"

Write-Host "Checking log directory.." -ForegroundColor Yellow
if (!(Test-Path $ExportDir)) {New-Item -Path $ExportDir -ItemType Directory -Force | Out-Null}
elseif (Test-Path $ExportDir) {Remove-Item "$ExportDir\*" -Recurse -Force}
Write-Host "Done"

Write-Host "Exporting APPLICATION logs.." -ForegroundColor Yellow
wevtutil epl Application "$ExportDir\$($env:COMPUTERNAME)_Application_Log.evtx"
Write-Host "Done"

Write-Host "Exporting SYSTEM logs.." -ForegroundColor Yellow
wevtutil epl System "$ExportDir\$($env:COMPUTERNAME)_System_Log.evtx"
Write-Host "Done"

```
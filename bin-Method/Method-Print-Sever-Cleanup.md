> [!WARNING]
> <ins>Administrator</ins> Terminal Required!

<br>

```powershell
Clear-Host

$spooldirectory = "C:\Windows\System32\spool\PRINTERS"

# Stop print spooler
write-host "Stopping Print Spooler Service..." -ForegroundColor Yellow

Stop-Service -Name Spooler -Force
Start-Sleep 5

# Remove contents of PRINTERS directory and restart service
$spoolerstatuspost = (Get-Service -Name spooler).Status

If ($spoolerstatuspost -eq "stopped") {
    Write-Host "Done!" -ForegroundColor Green
    
    Write-Host "Deleting contents of $($spooldirectory)..." -ForegroundColor Yellow
    
    Get-ChildItem -Path $spooldirectory -Include *.* -File -Recurse | ForEach-Object { $_.Delete() }
    Start-Sleep 5
    Write-Host "Done" -ForegroundColor Green
    
    write-host "Restarting Spooler Service..." -ForegroundColor Yellow
    Start-Service Spooler
    start-sleep 5

    $spoolerstatuspost2 = (Get-Service -Name spooler).Status

    If ($spoolerstatuspost2 -eq "running") {
        Write-Host "Done" -ForegroundColor Green

        write-host ""
        Write-Host "Script Complete." -ForegroundColor Cyan
    }
    Else {
        write-host "Spooler Service failed to start, manual check required" -ForegroundColor Red
    }
}
Else {
    write-host "Print Spooler Failed to Stop, manual intervention required.." -ForegroundColor Red
}
```

> [!WARNING]
> <ins>Administrator</ins> Terminal Required!

<br>

```powershell
Clear-Host

# --- Configuration ---
$SpoolDirectory = "C:\Windows\System32\spool\PRINTERS"

# --- Stop Print Spooler ---
Write-Host "Stopping Print Spooler Service..." -ForegroundColor Yellow
Stop-Service -Name Spooler -Force
Start-Sleep -Seconds 5

# --- Verify Stop and Execute Cleanup ---
$SpoolerStatusPost = (Get-Service -Name Spooler).Status

if ($SpoolerStatusPost -eq "Stopped") {
    Write-Host "Done!" -ForegroundColor Green

    # Delete Spool Files
    Write-Host "Deleting contents of $($SpoolDirectory)..." -ForegroundColor Yellow
    Get-ChildItem -Path $SpoolDirectory -Include *.* -File -Recurse | ForEach-Object { $_.Delete() }
    Start-Sleep -Seconds 5
    Write-Host "Done" -ForegroundColor Green
    
    # Restart Spooler Service
    Write-Host "Restarting Spooler Service..." -ForegroundColor Yellow
    Start-Service -Name Spooler
    Start-Sleep -Seconds 5
    
    # Final Status Check
    $SpoolerStatusPost2 = (Get-Service -Name Spooler).Status
    if ($SpoolerStatusPost2 -eq "Running") {
        Write-Host "Done" -ForegroundColor Green
        Write-Host ""
        Write-Host "Script Complete." -ForegroundColor Cyan
    }
    else {
        Write-Host "Spooler Service failed to start, manual check required" -ForegroundColor Red
    }
}
else {
    Write-Host "Print Spooler Failed to Stop, manual intervention required.." -ForegroundColor Red
}
```

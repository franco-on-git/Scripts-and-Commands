# Netstat

### Show Active and Monitor for String value
```powershell
clear-screen

# Pattern to search for (port, PID, IP, etc.)
$pattern = Read-Host "Enter String"


# Logfile 
$AmOrPm = Get-Date -UFormat %p
If ($AmOrPm -eq 'AM') {$AmPM = "am"}
ElseIf ($AmOrPm -eq 'PM') {$AmPM = "pm"}

$logfile = "$env:userprofile\desktop\Netstat_Log_$($pattern) -- $(Get-Date -f MM_dd_yyyy_hhmm)_$AmPM.txt"


# Store previously seen matches
$previous = @()

Write-Host "Monitoring for matches containing '$pattern'..."
Write-Host "Logging to: $logFile"
Write-Host "Press Ctrl+C to stop.`n"

while ($true) {

    cls

    # Get current matches
    $current = netstat -ano | Select-String $pattern | ForEach-Object { $_.Line }

    # Timestamp for logging
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")

    # Show active matches
    if ($current.Count -gt 0) {
        Write-Host "Current Active Matches:" -ForegroundColor Cyan
        $current | ForEach-Object { Write-Host "  $_" }

        # Log active matches
        Add-Content -Path $logFile -Value "`n[$timestamp] Active Matches:"
        $current | ForEach-Object { Add-Content -Path $logFile -Value "  $_" }
    }
    else {
        Write-Host "No active matches." -ForegroundColor Yellow
        Add-Content -Path $logFile -Value "`n[$timestamp] No active matches."
    }

    # Detect new matches
    $new = $current | Where-Object { $_ -notin $previous }

    if ($new.Count -gt 0) {
        Write-Host "`n*** NEW MATCHES DETECTED ***" -ForegroundColor Green
        $new | ForEach-Object { Write-Host "  $_" }
        Write-Host "*****************************************************************************`n"

        # Log new matches
        Add-Content -Path $logFile -Value "`n[$timestamp] *** NEW MATCHES DETECTED ***"
        $new | ForEach-Object { Add-Content -Path $logFile -Value "  $_" }
        Add-Content -Path $logFile -Value "*****************************************************************************"
    }

    # Update previous list
    $previous = $current

    Start-Sleep -Seconds 2
}

```
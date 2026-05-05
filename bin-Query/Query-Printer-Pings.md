# Query: Printer Pings


<b>Copy Script:</b>

```powershell
<# 
    Check-Printers.ps1
    Retrieves all printers, extracts IP addresses from port objects,
    tests connectivity, and logs results to C:\Install.
#>

clear-host

# Ensure log directory exists
$logDir = "C:\Install"
if (-not (Test-Path $logDir)) {
    New-Item -Path $logDir -ItemType Directory | Out-Null
}

# Create log file
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$logFile = "$logDir\PrinterPingResults_$timestamp.txt"
"Printer Connectivity Test - $timestamp" | Out-File $logFile

# Get printers
$printers = Get-Printer | Where-Object {$_.name -notlike "*xps*" -and $_.name -notlike "*pdf*"}

foreach ($p in $printers) {

    $name = $p.Name
    $portName = $p.PortName

    # Get port details (works for TCP/IP and WSD)
    $port = Get-PrinterPort -Name $portName -ErrorAction SilentlyContinue
    $ip = $port.PrinterHostAddress

    Write-Host "Printer: $name"
    Write-Host "Port: $portName"

    if (-not $ip) {
        Write-Host "  ⚠ No IP found (WSD or non-IP port)" -ForegroundColor Yellow
        "Printer: $name | Port: $portName | No IP found" | Out-File $logFile -Append
        Write-Host ""
        continue
    }

    Write-Host "Testing IP: $ip ..."

    if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
        Write-Host "  ✔ Reachable" -ForegroundColor Green
        "Reachable | Printer: $name | IP: $ip " | Out-File $logFile -Append
    } else {
        Write-Host "  ✖ NOT reachable" -ForegroundColor Red
        "NOT reachable | Printer: $name | IP: $ip " | Out-File $logFile -Append
    }

    Write-Host ""
}

Write-Host "Results saved to $logFile"


# ******************************************************

# Read the log file
$lines = Get-Content $logFile

# Extract lines that START with "Reachable"
$reachable = $lines | Where-Object { $_ -match '^Reachable' }

# Extract lines that START with "NOT Reachable"
$notReachable = $lines | Where-Object { $_ -match '^NOT Reachable' }

# Rebuild the file: Reachable first, blank line, then NOT Reachable
$final = @()
$final += $reachable
$final += ""          # blank line separator
$final += $notReachable

# Write back to the same file
$final | Set-Content $logFile

Invoke-Item $logFile
```
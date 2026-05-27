# Query: Printer Pings (active/not active)

> [!WARNING]
> <ins>Administrator</ins> terminal required!
<br>

```powershell

clear-host

# Ensure log directory exists
$logDir = "C:\Install"
if (-not (Test-Path $logDir)) {
    New-Item -Path $logDir -ItemType Directory | Out-Null
}

# Set am/pm stamp
$AmOrPm = Get-Date -UFormat %p
If ($AmOrPm -eq 'AM') {$AmPM = "am"}
ElseIf ($AmOrPm -eq 'PM') {$AmPM = "pm"}

# Create $log file
$timestamp = "Printer_Ping_Results - $(Get-Date -f "MM_dd_yyyy_hhmm")$AmOrPm"
$logfile = "$logdir\$timestamp.txt"

# Create new empty file
# Delete if exists
if (Test-Path $logfile) {
    Remove-Item $logfile -Force
}

# Create new empty file
New-Item -Path $logfile -ItemType File | Out-Null




# *********************************************************************

$env:COMPUTERNAME | Out-File $logfile -Append
$timestamp | Out-File $logfile -Append

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

# Extract header (first 2 lines)
$header = $lines[0..1]

# Extract reachable and not reachable
$reachable    = $lines | Where-Object { $_ -imatch '^Reachable' }
$notReachable = $lines | Where-Object { $_ -imatch '^NOT reachable' }

# Rebuild file with header preserved
$final = @()
$final += $header
$final += ""
$final += $reachable
$final += ""
$final += $notReachable

# Write back to the same file
$final | Set-Content $logFile

Invoke-Item $logfile

```

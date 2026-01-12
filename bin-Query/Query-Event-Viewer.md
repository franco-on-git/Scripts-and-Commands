# Query: Event Viewer

## <ins>SYSTEM</ins> - Any string:
- Modify `$StartTime` variable days for lenth of time.
- Modify or ommit `Select-Object` switch for data capture size.

```powershell
Clear-Host
$StringName = Read-Host "Enter Search String"

# Limit search to the last 24 hours to keep it fast
$StartTime = (Get-Date).AddDays(-10)

# Filter at the source by LogName and Time for high performance
$Events = Get-WinEvent -FilterHashtable @{ 
    LogName   = 'System', 'Application'
    StartTime = $StartTime 
} -ErrorAction SilentlyContinue |
    Where-Object { $_.Message -like "*$StringName*" } |
    Select-Object -First 25 |
    Sort-Object TimeCreated |
    Select-Object LogName, TimeCreated, Id, LevelDisplayName, Message
   

if ($Events) {
    $Events | Format-Table -AutoSize
} else {
    Write-Host "No events found matching '$StringName' in the last 24 hours." -ForegroundColor Yellow
}

```

<br>

## <ins>SYSTEM</ins> - Shutdowns & Restarts (Past 24hrs):
```powershell
Clear-Host

# Get date for 24 hours ago
$Yesterday = (Get-Date).AddDays(-1)

# Use FilterHashtable for both ID and Time filtering
$results = Get-WinEvent -FilterHashtable @{
    LogName   = 'System'
    ID        = 1074, 6006, 6005, 1076, 6008, 41
    StartTime = $Yesterday
} -ErrorAction SilentlyContinue

if ($results) {$results | 
               Select-Object TimeCreated, Id, Message | 
               Format-Table}
else {Write-Host "No Events Found!" -ForegroundColor Cyan}
 ```

<br>

## <ins>SYSTEM</ins> - Shutdowns & Restarts (ALL):

```powershell
Clear-Host

Write-Host "1074 - Process 'X' has initiated a restart/shutdown"
Write-Host "6006 - The event log service was stopped (Last service to go down before reboot)"
Write-Host "6005 - The event log service was started (One of the first services to come up after startup)"
Write-Host "1076 - Reason supplied by user 'X' for last unexpected shutdown"
Write-Host "6008 - The previous system shutdown was unexpected"
Write-Host "41 - System rebooted without clearly shutting down first"
Write-Host ""

Get-WinEvent -FilterHashtable @{ LogName = 'System'; Id = 1074, 6006, 6005, 1076, 6008, 41 } |
  Select-Object TimeCreated, Id, Message |
  Format-Table
```

# Query: Event Viewer

## <ins>SYSTEM</ins> - Any string:

```powershell
Clear-Host

$StringName = Read-Host "Enter Search String"

# Search both logs and store results in a variable
# FilterHashtable accepts an array of strings for LogName
$Events = Get-WinEvent -FilterHashtable @{ LogName = 'System', 'Application' } -ErrorAction SilentlyContinue |
    Where-Object { $_.Message -like "*$StringName*" } |
    Select-Object -First 25 |
    Select-Object LogName, TimeCreated, Id, LevelDisplayName, Message

# Check if any events were found
if ($Events) {
    $Events | Format-Table -AutoSize
}
else {
    Write-Host "No events Found!" -ForegroundColor Yellow
}

```

## <ins>SYSTEM</ins> - Shutdowns & Restarts (Past 24hrs):
```powershell
$Yesterday = (Get-Date) - (New-TimeSpan -Day 1)

Get-WinEvent -FilterHashtable @{ LogName = 'System' } |
  Where-Object {
    $_.Id -match '1074|6006|6005|1076|6008' -or
    ($_.Id -eq 41 -and $_.TimeCreated -ge $Yesterday)
  } |
  Select-Object TimeCreated, Id, Message |
  Out-GridView
 ```


## <ins>SYSTEM</ins> - Shutdowns & Restarts (ALL):

```powershell
Clear-Host

Write-Host "1074: Process 'X' has initiated a restart/shutdown"
Write-Host "6006: The event log service was stopped (Last service to go down before reboot)"
Write-Host "6005: The event log service was started (One of the first services to come up after startup)"
Write-Host "1076: Reason supplied by user 'X' for last unexpected shutdown"
Write-Host "6008: The previous system shutdown was unexpected"
Write-Host "41: System rebooted without clearly shutting down first"
Write-Host ""

Get-WinEvent -FilterHashtable @{ LogName = 'System' } |
  Where-Object { $_.Id -match '1074|6006|6005|1076|6008' -or $_.Id -eq 41 } |
  Select-Object TimeCreated, Id, Message |
  Out-GridView
```



## <ins>SHUTDOWNS/REBOOTS, APPLICATION & SYSTEM</ins> - Critial, Error, and Warning (Latest 10):
```powershell
cls


write-host " ___  _____      _____ ___      _____   _____ _    ___ "  -ForegroundColor Magenta
write-host "| _ \/ _ \ \    / / __| _ \___ / __\ \ / / __| |  | __|"  -ForegroundColor Magenta
write-host "|  _/ (_) \ \/\/ /| _||   /___| (__ \ V / (__| |__| _| "  -ForegroundColor Magenta
write-host "|_|  \___/ \_/\_/ |___|_|_\    \___| |_| \___|____|___|"  -ForegroundColor Magenta
                                                                                                                            

Get-WinEvent -FilterHashtable @{ LogName = 'System' } |
  Where-Object { $_.Id -match '1074|6006|6005|1076|6008' -or $_.Id -eq 41 } |
  Select-Object TimeCreated, Id, Message


write-host "  _____   _____ _____ ___ __  __ "  -ForegroundColor Magenta
write-host " / __\ \ / / __|_   _| __|  \/  |"  -ForegroundColor Magenta
write-host " \__ \\ V /\__ \ | | | _|| |\/| |"  -ForegroundColor Magenta
write-host " |___/ |_| |___/ |_| |___|_|  |_|"  -ForegroundColor Magenta
write-host ""
Write-Host ""
 

write-host "== CRITICAL ==" -ForegroundColor Cyan
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    Level   = 1
} -MaxEvents 10 | Select-Object TimeCreated, Id, LevelDisplayName, Message | Format-Table -AutoSize


write-host "== ERROR ==" -ForegroundColor Cyan
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    Level   = 2
} -MaxEvents 10 | Select-Object TimeCreated, Id, LevelDisplayName, Message | Format-Table -AutoSize


write-host "== WARNING Events ==" -ForegroundColor Cyan
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    Level   = 3
} -MaxEvents 10 | Select-Object TimeCreated, Id, LevelDisplayName, Message | Format-Table -AutoSize


write-host ""
write-host "    _   ___ ___ _    ___ ___   _ _____ ___ ___  _  _ " -ForegroundColor Magenta
write-host "   /_\ | _ \ _ \ |  |_ _/ __| /_\_   _|_ _/ _ \| \| |" -ForegroundColor Magenta
write-host "  / _ \|  _/  _/ |__ | | (__ / _ \| |  | | (_) | .` |" -ForegroundColor Magenta
write-host " /_/ \_\_| |_| |____|___\___/_/ \_\_| |___\___/|_|\_|" -ForegroundColor Magenta
                                 
write-host "== CRITICAL ==" -ForegroundColor Cyan
Get-WinEvent -FilterHashtable @{
    LogName = 'Application'
    Level   = 1
} -MaxEvents 10  -ErrorAction SilentlyContinue | Select-Object TimeCreated, Id, LevelDisplayName, Message | Format-Table -AutoSize


write-host "== ERROR ==" -ForegroundColor Cyan
Get-WinEvent -FilterHashtable @{
    LogName = 'Application'
    Level   = 2
} -MaxEvents 10 | Select-Object TimeCreated, Id, LevelDisplayName, Message | Format-Table -AutoSize


write-host "== WARNING Events ==" -ForegroundColor Cyan
Get-WinEvent -FilterHashtable @{
    LogName = 'Application'
    Level   = 3
} -MaxEvents 20 |  Format-Table -AutoSize                    
```
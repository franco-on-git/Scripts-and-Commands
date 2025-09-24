# Event Viewer Query
 Multiple quieries for searching Event Viewer logs.

## Query <ins>System Log</ins> for a **STRING**:

> [!NOTE]
> - Queries the **System** Event Log for specific set of words (string).

```
Clear-Host

$StringName = Read-Host "String"

Get-WinEvent -FilterHashtable @{ LogName = 'System' } |
  Where-Object { $_.Message -like "*$StringName*" } |
  Select-Object -First 25 |
  Out-GridView
```

## Query <ins>System Log</ins> for **SHUTDOWN\RESTARTS** Event ID:

```
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

## Query <ins>System Log</ins> for **SHUTDOWNS/RESTARTS** in past 24hrs.
```
$Yesterday = (Get-Date) - (New-TimeSpan -Day 1)

Get-WinEvent -FilterHashtable @{ LogName = 'System' } |
  Where-Object {
    $_.Id -match '1074|6006|6005|1076|6008' -or
    ($_.Id -eq 41 -and $_.TimeCreated -ge $Yesterday)
  } |
  Select-Object TimeCreated, Id, Message |
  Out-GridView
 ```

# ----------------------------------------------------------------------------------
 # Event Viewer: Search for SPECIFIC word in Service Control Manager Provider 
Get-WinEvent -FilterHashtable @{logname='system'; ProviderName='Service Control Manager'} | Where-Object  { $_.message -like '*vpos*' }  | Select-Object -first 15 | Format-Table -Wrap 

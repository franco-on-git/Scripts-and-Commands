# Event Viewer Query

> [!NOTE]
> Multiple quieries for searching Event Viewer logs.

## Query <ins>System Log</ins> for a **STRING**:

> [!NOTE]
> - Queries the **System** Event Log for specific set of words (string):

```
$StringName = read-host "String"
Get-WinEvent -FilterHashtable @{logname='system'} | Where-Object  { $_.message -like '*$stringname*' } |  Select-Object -first 25 | Out-GridView
```

## Query <ins>System Log</ins> for **SHUTDOWN\RESTARTS** Event ID:

```
cleart-host

write-host "1074: Process “X” has initiated a restart/shutdown"
write-host "6006: The event log service was stopped (Last service to go down before reboot)"
write-host "6005: The event log service was started (One of the first services to come up after startup)"
write-host "1076: Reason supplied by user “X” for last Unexpected sutdown"
write-host "6008: The previous system shutdown was unexpected"
write-host "41: System rebooted withtou clearly shutting down first"
Write-host ""

Get-WinEvent -FilterHashtable @{logname='system'} | Where-Object  {$_.id -match '1074|6006|6005|1076|6008' -or $_.id -eq '41' } | Select-Object timecreated,id,message | Out-GridView 
```

# ----------------------------------------------------------------------------------
# Event Viewer: Reboot\Restarts in Past day (ISE) 
$Yesterday = (Get-Date) - (New-TimeSpan -Day 1) 
Get-WinEvent -FilterHashtable @{logname='system'} | Where-Object  {$_.id -match '1074|6006|6005|1076|6008' -or $_.id -eq '41' -and $_.TimeCreated -ge $Yesterday  } | Select-Object timecreated,id,message | Out-GridView 
 

# ----------------------------------------------------------------------------------
 # Event Viewer: Search for SPECIFIC word in Service Control Manager Provider 
Get-WinEvent -FilterHashtable @{logname='system'; ProviderName='Service Control Manager'} | Where-Object  { $_.message -like '*vpos*' }  | Select-Object -first 15 | Format-Table -Wrap 

# Query User Logon History

> [!WARNING]
> - **Always Run Terminal as <ins>Administrator</ins>!**

> [!NOTE]
> - Query local system for logon history
> - Sifts through the past 1000 Security log events.
> - Groups them by user.
> - Bottom script shows all individual login events along with name and type.


### Copy Code:
```
Clear-Host

# Define logon event ID and log source
$logonEventId = 4624
$logSource = 'Security'

# Get recent logon events (filtering out system/service accounts)
$events = Get-WinEvent -FilterHashtable @{LogName=$logSource; ID=$logonEventId} -MaxEvents 1000 |
    Where-Object {
        $user = $_.Properties[5].Value
        $user -and $user -notmatch '^\$' -and $user -notmatch '^ANONYMOUS LOGON$' -and $user -notmatch '^SYSTEM$'
    } |
    Select-Object @{Name='User';Expression={$_.Properties[5].Value}}, TimeCreated

# Group by user and select the most recent entry per user
$uniqueUsers = $events | Sort-Object TimeCreated -Descending |
    Group-Object User |
    ForEach-Object { $_.Group | Sort-Object TimeCreated -Descending | Select-Object -First 1 }

# Show the last 5 unique users
Write-Host "User Logon History (20 Max):" -ForegroundColor Yellow
$uniqueUsers | Sort-Object TimeCreated -Descending | Select-Object -First 20 | Format-Table -AutoSize

Start-Sleep 3

Write-Host "------------------------------------------------------------------------"
Write-Host ""

Write-Host "Logon Types:" -ForegroundColor Yellow
Write-Host ""
write-host "2 - Iteractive - User logs in directly at the machine (keyboard/screen)"
write-host "3 - Network - Access via network (e.g., shared folders, printers)"
Write-Host "4 - Batch - Used by scheduled tasks or batch jobs"
write-host "5 - Service - Services logging in to run under specific accounts"
write-host "7 - Unlock - User unlocks a previously locked session"
write-host "10 - Remote Desktop - Remote Desktop or Terminal Services session"
write-host ""

Get-WinEvent -LogName Security -FilterXPath '*/System/EventID=4624' |
Sort-Object -Property TimeCreated -Descending |
Select-Object -First 500 -Property @{Name='User';Expression={$_.Properties[5].Value}}, TimeCreated, @{Name='LogonType';Expression={$_.Properties[8].Value}} |
Format-Table -AutoSize
```

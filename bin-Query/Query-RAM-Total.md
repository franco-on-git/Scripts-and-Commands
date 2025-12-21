
> [!NOTE]
> - Queries amount of memory and how much it's being used.

### Copy Code:
```powershell
clear-host

# Get memory stats
$mem = Get-CimInstance -ClassName Win32_OperatingSystem

# Calculate usage
$total = [math]::round($mem.TotalVisibleMemorySize / 1MB, 2)
$free  = [math]::round($mem.FreePhysicalMemory / 1MB, 2)
$used  = $total - $free
$percentUsed = [math]::round(($used / $total) * 100, 2)

# Output
Write-Host "Memory Usage:"
write-host "-------------"
Write-Host "$env:COMPUTERNAME"
Write-Host "Total:  $total MB"
Write-Host "Used:   $used MB ($percentUsed`%)"
Write-Host "Free:   $free MB"
write-host ""
```
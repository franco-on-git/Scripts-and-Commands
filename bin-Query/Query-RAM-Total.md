# Query: RAM Total
> [!NOTE]
> - Queries for total amount of system memory, total used and free memory, and does an 30-average utilization.

### Copy Code:
```powershell
clear-host

# Get memory stats
$mem = Get-CimInstance -ClassName Win32_OperatingSystem

# Calculate usage
$total = [math]::round($mem.TotalVisibleMemorySize / 1MB, 2)
$free  = [math]::round($mem.FreePhysicalMemory / 1MB, 2)

# Wrap the subtraction in round to ensure 2 decimal points
$used  = [math]::round($total - $free, 2)
$percentUsed = [math]::round(($used / $total) * 100, 2)

# *****************************************************

# Monitors RAM utilization for 30 seconds (1 sample per second)
write-host "Monitoring RAM utilization (30-Second Average)..." -ForegroundColor Cyan
Write-host "" 
$samples = Get-Counter -Counter "\Memory\% Committed Bytes In Use" -SampleInterval 1 -MaxSamples 30

# Calculate the average from the gathered samples
$averageUsage = ($samples.CounterSamples.CookedValue | Measure-Object -Average).Average

# *****************************************************

# Output
Write-Host "Memory Usage:" -ForegroundColor White
write-host "-------------" -ForegroundColor White
Write-Host "$env:COMPUTERNAME"
Write-Host "Total:  $total GB"
Write-Host "Used:   $used GB ($percentUsed`%)"
Write-Host "Free:   $free GB"
write-host ""
Write-Host "Average RAM Utilization over 30 seconds: $([math]::Round($averageUsage, 2))%"
write-host "" 
```
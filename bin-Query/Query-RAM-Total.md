# Query: RAM Total
> [!NOTE]
> - Queries for total amount of system memory, total used and free memory, and does an 30-average utilization.

### Copy Code:
```powershell
Clear-Host

# Get total physical memory
$mem = Get-CimInstance -ClassName Win32_OperatingSystem

$total = [math]::Round($mem.TotalVisibleMemorySize / 1MB, 2)
$free  = [math]::Round($mem.FreePhysicalMemory / 1MB, 2)
$used  = [math]::Round($total - $free, 2)

$percentUsed = [math]::Round(($used / $total) * 100, 2)
$percentFree = [math]::Round(($free / $total) * 100, 2)

# *****************************************************

# Monitor physical RAM utilization for 30 seconds
Write-Host "Monitoring RAM utilization (30-Second Average)..." -ForegroundColor Cyan
Write-Host ""

$usageSamples = @()

1..30 | ForEach-Object {

    $memSample = Get-CimInstance -ClassName Win32_OperatingSystem

    $sampleFree = $memSample.FreePhysicalMemory / 1MB
    $sampleUsedPercent = (($total - $sampleFree) / $total) * 100

    $usageSamples += $sampleUsedPercent

    Start-Sleep -Seconds 1
}

$averageUsage = ($usageSamples | Measure-Object -Average).Average

# *****************************************************

# Refresh memory stats for final output
$mem = Get-CimInstance -ClassName Win32_OperatingSystem

$free = [math]::Round($mem.FreePhysicalMemory / 1MB, 2)
$used = [math]::Round($total - $free, 2)

$percentUsed = [math]::Round(($used / $total) * 100, 2)
$percentFree = [math]::Round(($free / $total) * 100, 2)

# Output
Write-Host "Memory Usage:" -ForegroundColor White
Write-Host "-------------" -ForegroundColor White
Write-Host "$env:COMPUTERNAME"
Write-Host "Total:  $total GB"
Write-Host "Used:   $used GB ($percentUsed`%)"
Write-Host "Free:   $free GB ($percentFree`%)"
Write-Host ""

$ramutilavg = "$([math]::Round($averageUsage, 2))%"


if ($ramutilavg -gt 80) { Write-Host "Average RAM Utilization HIGH ($([math]::Round($averageUsage, 2))%)" -ForegroundColor Red }
else {Write-Host "Average RAM Utilization below threshold ($([math]::Round($averageUsage, 2))%)" -ForegroundColor green }
```

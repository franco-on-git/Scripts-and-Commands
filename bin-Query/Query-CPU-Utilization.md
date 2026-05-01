# Query: CPU Utilization

> [!WARNING]
> - **<ins>Administrator</ins> Terminal required!**

> [!NOTE]
> - Queries CPU load over a 30 second time interval. 

```
Clear-Host

# Define monitoring parameters
$samples = 45
$interval = 1 # 1 sample per second for 30 seconds

Write-Host "Monitoring CPU utilization for $samples seconds..." -ForegroundColor Cyan

# Collect samples and calculate the average
$cpuUsage = (Get-Counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval $interval -MaxSamples $samples |
    Select-Object -ExpandProperty CounterSamples |
    Select-Object -ExpandProperty CookedValue |
    Measure-Object -Average).Average

# Get the server name
$serverName = $env:COMPUTERNAME

# Report the results
Write-Host "---------------------------"
Write-Host "Server: $serverName"
Write-Host "Average CPU Utilization ($($samples) Sec Span): $([math]::Round($cpuUsage, 2))%"
Write-Host "---------------------------"

# Threshold check
if ($cpuUsage -lt 90) {
    Write-Host "CPU utilization below threshold (<90%)" -ForegroundColor Green
} else {
    Write-Host "Check CPU utilization (>90%)" -ForegroundColor Red
}
```

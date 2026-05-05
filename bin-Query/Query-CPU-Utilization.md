# Query: CPU Utilization

> [!WARNING]
> - **<ins>Administrator</ins> Terminal required!**

> [!NOTE]
> - Queries CPU load over a 30 second time interval. 

```
Clear-Host

# Get process info
function GetProcessInfo {

write-host ""
Write-Host "CPU Utilization Top Hitters:" -ForegroundColor Cyan

$cores = (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors

Get-Counter '\Process(*)\% Processor Time' -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty CounterSamples |
    Where-Object {
        $_.Status -eq 0 -and
        $_.InstanceName -notin "_Total","system"
    } |
    Sort-Object CookedValue -Descending |
    Select-Object -First 20 |
    ForEach-Object {
        # Extract base name (chrome#1 → chrome)
        $base = $_.InstanceName -replace '#\d+$',''

        # Try to match to a real process
        $proc = Get-Process -Name $base -ErrorAction SilentlyContinue |
                Sort-Object Id | Select-Object -First 1

        [PSCustomObject]@{
            Name   = $_.InstanceName
            'CPU%' = [math]::Round(($_.CookedValue / $cores), 2)
            Path   = $proc.MainModule.FileName
        }
    }

    }


# Define monitoring parameters
$samples = 30
$interval = 1 # 1 sample per second for $samples seconds

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
    Write-Host ""
    GetProcessInfo

} else {
    Write-Host "Check CPU utilization (>90%)" -ForegroundColor Red
    write-host ""
    GetProcessInfo

}
```

<br>

# Query: Top CPU Utilization Processes Only

> [!WARNING]
> - **<ins>Administrator</ins> Terminal required!**

> [!NOTE]
> - Queries for high CPU utilization and identifies top hitters.

```powershell
Clear-Host

$cores = (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors

Get-Counter '\Process(*)\% Processor Time' -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty CounterSamples |
    Where-Object {
        $_.Status -eq 0 -and
        $_.InstanceName -notin "_Total","Idle","System Idle Process","System"
    } |
    Sort-Object CookedValue -Descending |
    Select-Object -First 10 |
    ForEach-Object {
        $proc = Get-Process -Name $_.InstanceName -ErrorAction SilentlyContinue
        [PSCustomObject]@{
            Name   = $_.InstanceName
            'CPU%' = [math]::Round(($_.CookedValue / $cores), 2)
            Path   = $proc.MainModule.FileName
        }
    }
```



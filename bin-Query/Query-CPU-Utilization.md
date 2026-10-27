# CPU Utilization & Process Information

## Informational
Queries for CPU (%) utilization and processes taking up most of the resource. <br>
Helps quickly identify which processes are contributing most to CPU usage on the server

## Tasks
✅ Monitors overall CPU usage over a short period and calculates the average utilization.<br>
✅ Displays the server name and average CPU utilization percentage.<br>
✅ Compares the average CPU utilization against a 90% threshold.<br>
✅ Indicates whether CPU utilization is within normal limits or requires attention.<br>
✅ Identifies the top processes consuming the most CPU resources.<br>
✅ Filters the results to show only processes exceeding 8% CPU utilization.<br>
✅ Displays the process name, CPU utilization, process owner, and executable path.<br>


## Code Block

🔴 <ins>Administrator</ins> Terminal Required!</span> 🔴
```powershell

Clear-Host

# Get process info
function GetProcessInfo {

write-host ""
Write-Host "CPU Utilization Top Hitters (>8%):" -ForegroundColor Cyan

$cores = (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors

Get-Counter '\Process(*)\% Processor Time' -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty CounterSamples |
    Where-Object {
        $_.Status -eq 0 -and
        $_.InstanceName -notin "_Total","system"
    } |
    Sort-Object CookedValue -Descending |
    Where-Object { ($_.CookedValue / $cores) -gt 8 } |
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
            Owner  = (Get-CimInstance Win32_Process -Filter "ProcessId = $($proc.Id)" -ErrorAction SilentlyContinue |
                      Invoke-CimMethod -MethodName GetOwner -ErrorAction SilentlyContinue |
                      ForEach-Object { "$($_.Domain)\$($_.User)" })
            Path   = $proc.MainModule.FileName
        }
    }

    }

# Define monitoring parameters
$samples = 15
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



# Query System CPU Info
> [!Note]
> - No <ins>Admin</ins> Terminal required

## Copy Command:
```
Clear-Host

# Title
# ---------------------------------------------------------------------------------
Write-Host "`nPROCESSORS" -ForegroundColor Yellow
Write-Host "-----------"
Write-Host "** Virtual Platforms: Show processor resources ASSIGNED to them. **" -ForegroundColor Cyan
Write-Host "** Physical Platforms: Show ACTUAL host Sockets, Cores, and thread count. **" -ForegroundColor cyan

# Try CIM first, fallback to WMI if CIM returns nothing
# ---------------------------------------------------------------------------------
$cpus = Get-CimInstance Win32_Processor

if (-not $cpus) {
    $cpus = Get-WmiObject Win32_Processor
}

# Determine if virtual or physical
# ---------------------------------------------------------------------------------
$model = (Get-CimInstance Win32_ComputerSystem).Model
$platform = if ($model -match "Virtual|VMware|Hyper-V|VirtualBox") {
    "Virtual "
} else {
    "Physical "
}


# Determine platform
#----------------------------------------------------------------------------------
function Get-CloudPlatform {
    $ComputerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
    $SystemModel = $ComputerSystem.Model
    $SystemManufacturer = $ComputerSystem.Manufacturer

    if ($SystemModel -match "VirtualBox" -or $SystemModel -match "VMware Virtual Platform") {
        Write-Output "VMware"
    } elseif ($SystemManufacturer -match "Microsoft Corporation" -and (Get-Service -Name WindowsAzureGuestAgent -ErrorAction SilentlyContinue)) {
        Write-Output "Azure"
    } elseif ($SystemManufacturer -match "Google") {
        Write-Output "Google Cloud"
    } else {
        Write-Output "Unknown or Physical"
    }
}


# Guard against empty results
# ---------------------------------------------------------------------------------
if ($cpus) {
    $CPUname      = (Get-CimInstance Win32_Processor | Where-Object { $_.DeviceID -eq "CPU0" }).Name
    $totalSockets = ($cpus | Select-Object -ExpandProperty SocketDesignation | Get-Unique).Count
    $totalCores   = ($cpus | Measure-Object -Property NumberOfCores -Sum).Sum
    $totalThreads = ($cpus | Measure-Object -Property NumberOfLogicalProcessors -Sum).Sum

    [PSCustomObject]@{
        Environment = $Platform
        Platform    = Get-CloudPlatform
        CPU         = $cpuName
        Sockets     = [int]$totalSockets
        Cores       = [int]$totalCores
        Threads     = [int]$totalThreads
    }
}
else {
    Write-Warning "Unable to retrieve CPU information. Check system permissions or WMI availability."
}
```

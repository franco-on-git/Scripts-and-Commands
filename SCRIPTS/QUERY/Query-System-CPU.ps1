<#
    .NOTES
        Author: Franco-hq
        Created: 07/2025

    .DESCRIPTION
        -Simple query of CPU name, sockets, and threads
#>


# --------------------------------------------------------------------------------
Clear-Host


# Title
# ---------------------------------------------------------------------------------
Write-Host "`nPROCESSORS" -ForegroundColor Yellow
Write-Host "-----------"
Write-Host "** Virtual platforms will only show processor resources assigned to them **" -ForegroundColor Cyan
Write-Host "** Physical servers will show actual host Sockets, Cores, and thread count **" -ForegroundColor cyan


# Try CIM first, fallback to WMI if CIM returns nothing
# ---------------------------------------------------------------------------------
$cpus = Get-CimInstance Win32_Processor

if (-not $cpus) {
    $cpus = Get-WmiObject Win32_Processor
}


# Determine if virtual or physical
# ---------------------------------------------------------------------------------
$model = (Get-CimInstance -ClassName Win32_ComputerSystem).Model
$platform = if ($model -match "Virtual|VMware|Hyper-V|VirtualBox") {
    "Virtual "
} else {
    "Physical "
}


# Guard against empty results
# ---------------------------------------------------------------------------------
if ($cpus) {
    $CPUname      = (Get-CimInstance -ClassName Win32_Processor | Where-Object { $_.DeviceID -eq "CPU0" }).Name
    $totalSockets = ($cpus | Select-Object -ExpandProperty SocketDesignation | Get-Unique).Count
    $totalCores   = ($cpus | Measure-Object -Property NumberOfCores -Sum).Sum
    $totalThreads = ($cpus | Measure-Object -Property NumberOfLogicalProcessors -Sum).Sum

    [PSCustomObject]@{
        Environment = $Platform
        Model       = $model
        CPU         = $cpuName
        Sockets     = $totalSockets
        Cores       = $totalCores
        Threads     = $totalThreads
    }
}
else {
    Write-Warning "Unable to retrieve CPU information. Check system permissions or WMI availability."
}

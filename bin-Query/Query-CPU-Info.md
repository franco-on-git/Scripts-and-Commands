# Query: CPU Info
> [!Note]
> - No <ins>Admin</ins> Terminal required

## Copy Command:

```powershell
Clear-Host

#Requires -Version 5.1

<#
.SYNOPSIS
    Collects processor and platform inventory information from the local system.

.DESCRIPTION
    Invoke-PlatformInventory gathers detailed processor and platform information
    using WMI/CIM queries. It retrieves CPU name, number of cores, logical
    processors, total physical memory, and operating system details, then
    outputs a structured inventory object.

.PARAMETER ComputerName
    The name of the computer to query. Defaults to the local machine.

.PARAMETER OutputPath
    Optional path to export the inventory results as a JSON file.

.EXAMPLE
    .\Invoke-PlatformInventory.ps1
    Runs the inventory against the local machine and displays results.

.EXAMPLE
    .\Invoke-PlatformInventory.ps1 -ComputerName "Server01" -OutputPath "C:\Inventory\Server01.json"
    Runs the inventory against Server01 and exports results to a JSON file.

.NOTES
    Author:  Franco-On-Git
    Version: 1.2.0

    Changelog:
        1.2.0 - Added #Requires directive, standardized comment-based help block,
                fixed $cpuName casing inconsistency.
        1.1.0 - Added memory and OS inventory sections.
        1.0.0 - Initial release with basic CPU inventory.
#>

Clear-Host

# Title
# ---------------------------------------------------------------------------------
Write-Host "`nPROCESSORS" -ForegroundColor Yellow
Write-Host "-----------"
Write-Host "Platform:" -ForegroundColor Cyan
Write-Host "      - VIRTUAL:  Processor resources ASSIGNED to VM." -ForegroundColor Cyan
Write-Host "      - PHYSICAL: Sockets, Cores, and thread count on ACTUAL host." -ForegroundColor cyan

# Try CIM first, fallback to WMI if CIM returns nothing
# ---------------------------------------------------------------------------------
$cpus = Get-CimInstance Win32_Processor

if (-not $cpus) {
    $cpus = Get-WmiObject Win32_Processor
}

# Determine environment (virtual or physical)
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

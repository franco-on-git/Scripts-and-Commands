<#
    .NOTES
        Author: Franco-hq
        Created: 07/2025

    .DESCRIPTION
        -Simple query of CPU name, sockets, and threads
#>


# ---------------------------------------------------------------------------------
Clear-Host

# Title
Write-Host "`nPROCESSORS" -ForegroundColor Yellow
Write-Host "-----------"
Write-Host "** Virtual platforms will only show Cores\Threads assigned to them **" -ForegroundColor Cyan
Write-Host "** Physical servers will show actual hardware Core\Thread count **" -ForegroundColor cyan

# Determine if virtual or physical
$platform = Get-CimInstance -ClassName Win32_ComputerSystem
$result = if ($platform.Model -match "Virtual|VMware|Hyper-V|VirtualBox") {
    "Virtual "
} else {
    "Physical "
}

# Fetch processor details
$cpuName = (Get-CimInstance -ClassName Win32_Processor | Where-Object { $_.DeviceID -eq "CPU0" }).Name
$coreCount = (Get-WmiObject -Class Win32_ComputerSystem).NumberOfProcessors
$threadCount = (Get-CimInstance -ClassName Win32_Processor | Measure-Object NumberOfLogicalProcessors -Sum).Sum

# Build custom object for output
$cpuInfo = [PSCustomObject]@{
    Platform  = $result
    Processor = $cpuName
    Cores     = $coreCount
    Threads   = $threadCount
}

# Output results
Write-Output $cpuInfo
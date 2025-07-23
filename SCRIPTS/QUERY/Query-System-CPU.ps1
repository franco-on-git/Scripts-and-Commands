<#
    .NOTES
        Author: Franco-hq
        Created: 07/2025

    .DESCRIPTION
        -Simple query of CPU name, sockets, and threads
#>


# ---------------------------------------------------------------------------------
Clear-Host

# Display header
Write-Host "`nPROCESSORS" -ForegroundColor Yellow
Write-Host "-----------"

# Fetch processor details
$cpuName = (Get-CimInstance -ClassName Win32_Processor | Where-Object { $_.DeviceID -eq "CPU0" }).Name
$coreCount = (Get-WmiObject -Class Win32_ComputerSystem).NumberOfProcessors
$threadCount = (Get-CimInstance -ClassName Win32_Processor | Measure-Object NumberOfLogicalProcessors -Sum).Sum

# Build custom object for output
$cpuInfo = [PSCustomObject]@{
    CPU     = $cpuName
    Cores   = $coreCount
    Threads = $threadCount
}

# Output results
Start-Sleep -Seconds 1
Write-Output $cpuInfo
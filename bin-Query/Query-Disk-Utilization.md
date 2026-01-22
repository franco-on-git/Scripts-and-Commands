# Query: Disk Information

## Disk Utilization
```powershell
Clear-Host

$DriveletterInput = Read-Host "Enter Drive Letter"
$Driveletter = "$($DriveletterInput.Trim().ToUpper()):"
write-host ""

# 1. GET DATA ONCE
$DriveSearch = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = '$Driveletter'"

 # 2. CALCULATE DATA locally
    $UsedGB = [math]::Round(($DriveSearch.Size - $DriveSearch.FreeSpace) / 1GB, 2)
    $SizeGB = [math]::Round($DriveSearch.Size / 1GB, 2)
    $PercentUsed = [math]::Round(($UsedGB / $SizeGB) * 100, 2)

if ($DriveSearch) {
   
    # 3. DISPLAY TABLE
     if ($PercentUsed -lt 80) {
    Write-Host "`nDrive utilization is below 80% threshold:" -ForegroundColor Green
    $DriveSearch | Select-Object @(
        @{L = "Hostname";     E = { $env:COMPUTERNAME }},
        @{L = "Drive";        E = { $_.DeviceID }},
        @{L = "Capacity(GB)"; E = { $SizeGB }},
        @{L = "Used(GB)";     E = { $UsedGB }},
        @{L = "(%)Used";      E = { $PercentUsed }},
        @{L = "Free(GB)";     E = { [math]::Round($_.FreeSpace / 1GB, 2) }},
        @{L = "(%)Free";      E = { [math]::Round(($_.FreeSpace / $_.Size) * 100, 2) }}
    ) | Format-List
    }

    # 4. THRESHOLD CHECK
    elseif ($PercentUsed -gt 80) {
        Write-Host "WARNING: Used space is greater than 80% ($PercentUsed%)!" -ForegroundColor Red
        $DriveSearch | Select-Object @(
        @{L = "Hostname";     E = { $env:COMPUTERNAME }},
        @{L = "Drive";        E = { $_.DeviceID }},
        @{L = "Capacity(GB)"; E = { $SizeGB }},
        @{L = "Used(GB)";     E = { $UsedGB }},
        @{L = "(%)Used";      E = { $PercentUsed }}
    ) | Format-List
    }

} else {
    Write-Host "Drive '$($Driveletter)' not found!" -ForegroundColor Yellow
}
```

<br> 

## SSD/HDD Disks Only (Type 3):
```powershell
Get-WmiObject -Class Win32_LogicalDisk |
    Where-Object { $_.DriveType -eq 3 } |
    Select-Object @(
        @{L = "Hostname";     E = { $_.__Server }},
        @{L = "Drive";        E = { $_.DeviceID }},
        @{L = "Capacity(GB)"; E = { [math]::Round($_.Size / 1GB, 2) }},
        @{L = "Used(GB)";     E = { [math]::Round($_.Size / 1GB - $_.FreeSpace / 1GB, 2) }},
        @{L = "(%)Used";      E = { [math]::Round((($_.Size - $_.FreeSpace) / $_.Size) * 100, 2) }},
        @{L = "Free(GB)";     E = { [math]::Round($_.FreeSpace / 1GB, 2) }},
        @{L = "(%)Free";      E = { [math]::Round(($_.FreeSpace / $_.Size) * 100, 2) }}
    ) 
```

<br>

## <ins>All</ins> Locally Attached Disks (USB | Network Drives | Media drives):
```powershell
$DiskType = @{
    2 = "USB"
    3 = "HDD"
    4 = "NETWORK"
    5 = "CD-ROM"
}

Get-WmiObject -Class Win32_LogicalDisk |
    Select-Object @(
        @{L = "Hostname";     E = { $_.__Server }},
        @{L = "Drive";        E = { $_.DeviceID }},
        @{L = "Type";         E = { $DiskType.Item([int]$_.DriveType) }},
        @{L = "Capacity(GB)"; E = { [math]::Round($_.Size / 1GB, 2) }},
        @{L = "Used(GB)";     E = { [math]::Round($_.Size / 1GB - $_.FreeSpace / 1GB, 2) }},
        @{L = "(%)Used";      E = { [math]::Round((($_.Size - $_.FreeSpace) / $_.Size) * 100, 2) }},
        @{L = "Free(GB)";     E = { [math]::Round($_.FreeSpace / 1GB, 2) }},
        @{L = "(%)Free";      E = { [math]::Round(($_.FreeSpace / $_.Size) * 100, 2) }} 
        )
```

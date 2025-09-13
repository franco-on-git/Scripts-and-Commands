# Query Locally Attached Disks Only (Type 3 - SSD\HDD Only)

```
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
    ) |
    Out-GridView
```

# Query <ins>ALL</ins> Disks Attached To The Host

```
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
        ) |
    Out-GridView
```


<#
    .NOTES
        Author: Roboute Guilliman
        Created: 04/2025

    .SYNOPSIS
        Disk Types:
            -Type 2: USB
            -Type 3: HDD
            -Type 4: Network
            -Type 5: CD-ROM
#>

# ----------------------------------------------------------------------------------
# QUERY LOCALLY ATTACHED DISKS ONLY (TYPE 3)
Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | Select-Object @{L="Hostname";E={$_.__Server}},
                                                                                           @{L="Drive";E={$_.DeviceID}}, 
                                                                                           @{L="Capacity(GB)";E={[math]::round($_.Size/1GB,2)}}, 
                                                                                           @{L="Used(GB)";E={[math]::round($_.Size/1GB - $_.FreeSpace/1GB,2)}},                                          
                                                                                           @{L="(%)Used";E={[Math]::Round(((($_.Size - $_.FreeSpace) / $_.Size) * 100),2)}},
                                                                                           @{L="Free(GB)";E={[math]::round($_.FreeSpace/1GB,2)}}, 
                                                                                           @{L="(%)Free";E={[Math]::round((($_.freespace/$_.size) * 100),2)}} | 
                                                                             Out-GridView



# ----------------------------------------------------------------------------------
# QUERY ALL DISKS ON HOST
$DiskType = @{
    2 = "USB"
    3 = "HDD"
    4 = "NETWORK"
    5 = "CD-ROM"}
 
 Get-WmiObject -Class Win32_LogicalDisk  | Select-Object @{L="Hostname";E={$_.__Server}},
                                                         @{L="Drive";E={$_.DeviceID}}, 
                                                         @{L='Type';E={$DiskType.item([int]$_.DriveType)}},
                                                         @{L="Capacity(GB)"; E={[math]::round($_.Size/1GB,2)}}, 
                                                         @{L="Used(GB)"; E={[math]::round($_.Size/1GB - $_.FreeSpace/1GB,2)}},                                          
                                                         @{L="(%)Used";E= {[Math]::Round(((($_.Size - $_.FreeSpace) / $_.Size) * 100),2)}},
                                                         @{L="Free(GB)"; E={[math]::round($_.FreeSpace/1GB,2)}}, 
                                                         @{L="(%)Free";E={[Math]::round((($_.freespace/$_.size) * 100),2)}} | 
                                           Out-GridView
                                        


# ----------------------------------------------------------------------------------

# ====(OLD DEPRECATED)====

# CONVERT AND L DISK SIZES TO KB/MB/GB 
FUNCTION Convert-BytesToSize 
{ 
[CmdletBinding()] 
Param 
( 
[parameter(Mandatory=$False,Position=0)][int64]$Size 
) 

#Decide what is the type of size 
Switch ($Size) 
{ 
{$Size -gt 1PB} 
{ 
Write-Verbose “Convert to PB” 
$NewSize = “$([math]::Round(($Size / 1PB),2))PB” 
Break 
} 
{$Size -gt 1TB} 
{ 
Write-Verbose “Convert to TB” 
$NewSize = “$([math]::Round(($Size / 1TB),2))TB” 
Break 
} 
{$Size -gt 1GB} 
{ 
Write-Verbose “Convert to GB” 
$NewSize = “$([math]::Round(($Size / 1GB),2))GB” 
Break 
} 
{$Size -gt 1MB} 
{ 
Write-Verbose “Convert to MB” 
$NewSize = “$([math]::Round(($Size / 1MB),2))MB” 
Break 
} 
{$Size -gt 1KB} 
{ 
Write-Verbose “Convert to KB” 
$NewSize = “$([math]::Round(($Size / 1KB),2))KB” 
Break 
} 
Default 
{ 
Write-Verbose “Convert to Bytes” 
$NewSize = “$([math]::Round($Size,2))Bytes” 
Break 
} 
} 
Return $NewSize 
} 

 Get-WmiObject win32_logicaldisk | Where-Object {$_.DeviceID -ne "A:" -and $_.DeviceID -ne "B:"} |  
                                  Select-Object @{E={$_.__Server};L="Computer"}, 
                                  @{E={$_.DeviceID};L="Drive"}, 
                                  @{E={Convert-BytesToSize $_.Size};L="Capacity"}, 
                                  @{E={Convert-BytesToSize $_.freespace};L="FreeSpace"}, 
                                  @{E={[Math]::round((($_.freespace/$_.size) * 100),2)};L="(%)Free"} | Out-GridView 


                                  
<# 

Disk Type 2: USB
Disk Type 3: HDD
Disk Type 4: Network
Disk Type 5: CD-ROM

#>

#-------------------------------------------------------------------------------------------------------------
# QUERY LOCALLY ATTACHED DISKS (Type 3 Only)
Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | 
                                         Select-Object @{expression={$_.__Server};Label="Hostname"},
                                         @{Label="Drive";Expression={$_.DeviceID}}, 
                                         @{Label="Capacity(GB)"; Expression={[math]::round($_.Size/1GB,2)}}, 
                                         @{Label="Used(GB)"; Expression={[math]::round($_.Size/1GB - $_.FreeSpace/1GB,2)}},                                          
                                         @{Label ="(%)Used";Expression= {[Math]::Round(((($_.Size - $_.FreeSpace) / $_.Size) * 100),2)}},
                                         @{Label="Free(GB)"; Expression={[math]::round($_.FreeSpace/1GB,2)}}, 
                                         @{Label="(%)Free";Expression={[Math]::round((($_.freespace/$_.size) * 100),2)}} | 
                                         Out-GridView

#-------------------------------------------------------------------------------------------------------------                                        
# QUERY ALL DISK TYPES
$DiskType = @{
    2 = "USB"
    3 = "HDD"
    4 = "NETWORK"
    5 = "CD-ROM"}
 
 Get-WmiObject -Class Win32_LogicalDisk  | Select-Object @{expression={$_.__Server};Label="Hostname"},
                                          @{Label="Drive";Expression={$_.DeviceID}}, 
                                          @{Label='Type';Expression={$DiskType.item([int]$_.DriveType)}},
                                          @{Label="Capacity(GB)"; Expression={[math]::round($_.Size/1GB,2)}}, 
                                          @{Label="Used(GB)"; Expression={[math]::round($_.Size/1GB - $_.FreeSpace/1GB,2)}},                                          
                                          @{Label ="(%)Used";Expression= {[Math]::Round(((($_.Size - $_.FreeSpace) / $_.Size) * 100),2)}},
                                          @{Label="Free(GB)"; Expression={[math]::round($_.FreeSpace/1GB,2)}}, 
                                          @{Label="(%)Free";Expression={[Math]::round((($_.freespace/$_.size) * 100),2)}} | 
                                          Out-GridView
                                        

#-------------------------------------------------------------------------------------------------------------
# CONVERT AND LABEL DISK SIZES TO KB/MB/GB 
# ======================================== 
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
                                  Select-Object @{expression={$_.__Server};Label="Computer"}, 
                                  @{Expression={$_.DeviceID};Label="Drive"}, 
                                  @{Expression={Convert-BytesToSize $_.Size};Label="Capacity"}, 
                                  @{Expression={Convert-BytesToSize $_.freespace};Label="FreeSpace"}, 
                                  @{Expression={[Math]::round((($_.freespace/$_.size) * 100),2)};Label="(%)Free"} | Out-GridView 


                                  
<#
    .NOTES
        Author: Franco-hq
        Created: 09/2024

    .SYNOPSIS
        Remote-query a machine. 

    .DESCRIPTION
        NO SCRIPTBLOCK
            -Query machine directly
        WITH SCRIPTBLOCK
            -Inititate remote session and run commands using scriptblock 
#>


# NO SCRIPT BLOCK - External Commands 
# ----------------------------------------------------------------------------------
Function Get-File($initialDirectory) {    
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | 
 Out-Null 

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog 
 $OpenFileDialog.initialDirectory = $initialDirectory 
 $OpenFileDialog.filter = "All files (*.*)| *.*" 
 $OpenFileDialog.ShowDialog() | Out-Null 
 $OpenFileDialog.filename 
} 

$ListSelect= Get-File 

$servers = Get-Content $ListSelect

$Scopename = (Get-ChildItem $servers).name 

foreach ($server in $Scopename) {write-host $server 
                                 quser /server:$server; write-host ""}    

 

# WITH SCRIPT-BLOCK
# ----------------------------------------------------------------------------------
Function Get-File($initialDirectory) {    
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | 
 Out-Null 

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog 
 $OpenFileDialog.initialDirectory = $initialDirectory 
 $OpenFileDialog.filter = "All files (*.*)| *.*" 
 $OpenFileDialog.ShowDialog() | Out-Null 
 $OpenFileDialog.filename 
} 

$scopeip = Get-File 

$servers = Get-Content $scopeip 

foreach ($server in $servers) {Invoke-Command -ComputerName $server -ScriptBlock { 
                                                                                  $env:COMPUTERNAME;  
                                                                                  (Get-NetIPAddress | Where-Object {$_.addressfamily -ne "IPv6" -and $_.IPAddress -like "10.*"}).IPAddress}        
                                                                                   write-host " "  
                                                                                  }

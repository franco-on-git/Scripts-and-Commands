<#
   .NOTES
        -Author: Roboute Guilliman
        -Created: 10/2024

    .SYNOPSIS
        -Uses an array to query DNS entries for servers from a server list

    .DESCRIPTION
        -Plug in your query in the "ForEach" brackets 
#>


# ----------------------------------------------------------------------------------
Function Get-File($initialDirectory) 
{    
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |  Out-Null 
 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog 
 $OpenFileDialog.initialDirectory = $initialDirectory 
 $OpenFileDialog.filter = "All files (*.*)| *.*" 
 $OpenFileDialog.ShowDialog() | Out-Null 
 $OpenFileDialog.filename 
} 

# Variable pointing to new object
$ServerList = Get-File

# Get contents of new object variable
$servers = Get-Content $ServerList 

# Array with contents from file selected
$arraylist = @()

foreach ($server in $servers) {$arraylist += resolve-DnsName $server -ea SilentlyContinue | Where-Object {$_.section -eq "Answer"} | Select-Object name,ipaddress}

$arraylist 
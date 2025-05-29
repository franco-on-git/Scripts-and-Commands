
# ----Query all applications on system----
Get-Package -ProviderName Programs -IncludeWindowsInstaller | Select-Object name,version | Sort-Object Name | Format-Table -Auto

# ----Query for specific application----
Get-Package -ProviderName Programs -IncludeWindowsInstaller | Where-Object {$_.name -like "*nessus*"} | Select-Object name,version | Sort-Object Name | Format-Table -Auto

# ----Query using ARRAY----

Function Get-File($initialDirectory) 
{    
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |  Out-Null 
 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog 
 $OpenFileDialog.initialDirectory = $initialDirectory 
 $OpenFileDialog.filter = "All files (*.*)| *.*" 
 $OpenFileDialog.ShowDialog() | Out-Null 
 $OpenFileDialog.filename 
} 

# variable pointing to new object
$ServerList = Get-File

# get contents of new object variable
$servers = Get-Content $ServerList 

# array with contents from file selected
$arraylist = @()

foreach ($server in $servers) {$arraylist += Get-Package -ProviderName Programs -IncludeWindowsInstaller | Where-Object {$_.name -like "*nessus*"} | Select-Object name,version | Sort-Object Name | Format-Table -Auto}

$arraylist 


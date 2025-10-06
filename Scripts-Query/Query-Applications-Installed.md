# Query Installed Applications


## PowerShell (Get-Package)

> [!NOTE]
> - Queries for install software using the **Get-Package** command-let. 
> - No <ins>Admin</ins> console required. 
> - Use the `*` to get a full list of programs.

```
Clear-Host

$appsearch = Read-Host "App Name"

Get-Package -ProviderName Programs -IncludeWindowsInstaller |
  Where-Object { $_.Name -like "*$appsearch*" } |
  Select-Object  @{Name='Hostname';Expression={$env:COMPUTERNAME}},Name, Version |
  Sort-Object Name |
  Format-Table -Auto
```

## PowerShell (Get-ItemProperty)

> [!NOTE]
> - Queries for install software by seraching the **Uninstall** directories in HKLM registry hive. 
> - No <ins>Admin</ins> console required. 
> - Use the `*` to get a full list of programs.

```
Clear-Host

$appsearch = Read-Host "App Name"

Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*, 
                 HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
  Where-Object { $_.DisplayName -like "*$appsearch*" } |
  Select-Object @{Name='Hostname';Expression={$env:COMPUTERNAME}},DisplayName, DisplayVersion, Publisher,
    @{Name = 'InstallDate'; Expression = {
      if ($_.InstallDate -match '^\d{8}$') {
        [datetime]::ParseExact($_.InstallDate, 'yyyyMMdd', $null).ToString('MM/dd/yyyy')
      } else {
        $_.InstallDate
      }
    }} |
  Sort-Object DisplayName
```


## Query <ins>Server List</ins> using ARRAY

> [!NOTE]
> - Query a list of servers for application\s using an array.
> - > - Use the `*` to get a full list of programs.

```
Function Get-File($initialDirectory) 
{    
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |  Out-Null 
 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog 
 $OpenFileDialog.initialDirectory = $initialDirectory 
 $OpenFileDialog.filter = "All files (*.*)| *.*" 
 $OpenFileDialog.ShowDialog() | Out-Null 
 $OpenFileDialog.filename 
} 

Clear-Host

$appsearch = Read-Host "App Name"

# variable pointing to new object
$ServerList = Get-File

# get contents of new object variable
$servers = Get-Content $ServerList 

# array with contents from file selected
$arraylist = @()

foreach ($server in $servers) {$arraylist += Get-Package -ProviderName Programs -IncludeWindowsInstaller | Where-Object {$_.name -like "*$appsearch*"} | Select-Object name,version | Sort-Object Name | Format-Table -Auto}

$arraylist 
```


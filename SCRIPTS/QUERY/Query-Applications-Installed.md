# Query Installed Applications


## PowerShell (Get-Package)
```
Clear-Host

$appsearch = Read-Host "App Name"

Get-Package -ProviderName Programs -IncludeWindowsInstaller |
  Where-Object { $_.Name -like "*$appsearch*" } |
  Select-Object Name, Version |
  Sort-Object Name |
  Format-Table -Auto
```

## PowerShell (Get-ItemProperty)

>[!NOTE]
>Use the `*` to get a full list of programs.

```
Clear-Host

$appsearch = Read-Host "App Name"

Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*, 
                 HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
  Where-Object { $_.DisplayName -like "*$appsearch*" } |
  Select-Object DisplayName, DisplayVersion, Publisher,
    @{Name = 'InstallDate'; Expression = {
      if ($_.InstallDate -match '^\d{8}$') {
        [datetime]::ParseExact($_.InstallDate, 'yyyyMMdd', $null).ToString('MM/dd/yyyy')
      } else {
        $_.InstallDate
      }
    }} |
  Sort-Object DisplayName
```


## Query using ARRAY
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

# variable pointing to new object
$ServerList = Get-File

# get contents of new object variable
$servers = Get-Content $ServerList 

# array with contents from file selected
$arraylist = @()

foreach ($server in $servers) {$arraylist += Get-Package -ProviderName Programs -IncludeWindowsInstaller | Where-Object {$_.name -like "*nessus*"} | Select-Object name,version | Sort-Object Name | Format-Table -Auto}

$arraylist 
```


# Command-Line (CMD)
```
sc.exe delete ServiceName 
sc.exe \\server delete "MyService" 
```

# PowerShel <v5 (WMI) 
```
$service = Get-WmiObject -Class Win32_Service -Filter "Name='servicename'" 
$service.delete() 
```

# PowerShell >v6 (Commandlet)
```
Remove-Service -Name ServiceName 
```
 


 

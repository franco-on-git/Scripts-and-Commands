# Command-Line (CMD)
```
sc.exe delete ServiceName 
sc.exe \\server delete "MyService" 
```

# PowerShell <v5 (WMI) 
```
$service = Get-WmiObject -Class Win32_Service -Filter "Name='servicename'" 
$service.delete() 
```

# PowerShell >v6 (Command-let)
```
Remove-Service -Name ServiceName 
```
 


 

> [!IMPORTANT]
> **Run Terminal as <ins>Administrator</ins>!**

 
# Command-Line (CMD)
> [!IMPORTANT]
> **Run Terminal as <ins>Administrator</ins>!**

```
sc.exe delete ServiceName 
sc.exe \\server delete "MyService" 
```

# PowerShell <v5 (WMI) 
> [!IMPORTANT]
> **Run Terminal as <ins>Administrator</ins>!**

```
$service = Get-WmiObject -Class Win32_Service -Filter "Name='servicename'" 
$service.delete() 
```

# PowerShell >v6 (Command-let)
> [!IMPORTANT]
> **Run Terminal as <ins>Administrator</ins>!**

```
Remove-Service -Name ServiceName 
```
 


 

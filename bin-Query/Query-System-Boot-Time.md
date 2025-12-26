# Query: System Boot Time

> [!WARNING]
> - **<ins>Administrator</ins> Terminal required!**

## PowerShell (CIM)
```
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object LastBootUpTime 
```

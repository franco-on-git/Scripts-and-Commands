> [!IMPORTANT]
> **Run CMD as <ins>Administrator</ins>!**

Start CMD and run command:
```
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object LastBootUpTime 
```

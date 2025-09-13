> [!WARNING]
> **Always Run Terminal as <ins>Administrator</ins>!**

```
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object LastBootUpTime 
```

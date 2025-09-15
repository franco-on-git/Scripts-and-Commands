## Command-Line
```
wmic bios get serialnumber
```


## Powershell
```
(Get-WmiObject -Class Win32_BIOS).SerialNumber
```
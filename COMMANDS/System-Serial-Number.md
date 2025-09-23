# Query for Serial Number

> [!NOTE]
> - Query system for hardware serial number.

## Command-Line (CMD)
```
wmic bios get serialnumber
```


## Powershell (WMI)
```
(Get-WmiObject -Class Win32_BIOS).SerialNumber
```

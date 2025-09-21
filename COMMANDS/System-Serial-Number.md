# Command-Line (CMD)
```
wmic bios get serialnumber
```


# Powershell (WMI)
```
(Get-WmiObject -Class Win32_BIOS).SerialNumber
```

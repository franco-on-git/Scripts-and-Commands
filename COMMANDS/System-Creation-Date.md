## Windows Native Command
```
systeminfo | find /i "install date"
```

## PowerShell (WMI)
```
([WMI]'').ConvertToDateTime((Get-WmiObject Win32_OperatingSystem).InstallDate)
```

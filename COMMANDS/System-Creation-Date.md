# System Info
```
systeminfo | find /i "install date"
```

# WMI class
```
([WMI]'').ConvertToDateTime((Get-WmiObject Win32_OperatingSystem).InstallDate)
```

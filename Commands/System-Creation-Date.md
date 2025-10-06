# Machine Creation Date

> [!NOTE]
> - Queries for the creation date (installation) of the Windows OS.
> - No **Admin** terminal required.

## Windows Native Command
```
systeminfo | find /i "install date"
```

## PowerShell (WMI)
```
([WMI]'').ConvertToDateTime((Get-WmiObject Win32_OperatingSystem).InstallDate)
```

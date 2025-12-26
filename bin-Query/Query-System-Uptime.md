
```powershell
Clear-Host

$OS = Get-CimInstance Win32_OperatingSystem
$BootTime = $OS.LastBootUpTime
$Uptime = (Get-Date) - $BootTime

[PSCustomObject]@{
    # "hh" = 12-hour, "mm" = minutes, "tt" = AM/PM
    LastBootTime = $BootTime.ToString("MM/dd/yyyy hh:mm tt")
    Uptime       = "{0}d {1}h {2}m" -f $Uptime.Days, $Uptime.Hours, $Uptime.Minutes
}
```
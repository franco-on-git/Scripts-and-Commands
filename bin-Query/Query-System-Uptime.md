# System Uptime

Primarily queries for system's CPU information and physical/virtual environment setup. 

<p align="left">
  <img src="../vector-img/system-uptime.png">
  <br/>
</p>

## Script Tasks
✅ One-liner for a quick grab of uptime information.<br>
✅ Long-script creates a custom object to gather the uptime information

## Script Permissions
🔵 Standard non-admin access

### # One-Liner

```powershell
$os = Gcim Win32_OperatingSystem; [pscustomobject]@{LastBootUpTime=$os.LastBootUpTime; Uptime="{0} days, {1} hours, {2} minutes" -f ((Get-Date)-$os.LastBootUpTime).Days, ((Get-Date)-$os.LastBootUpTime).Hours, ((Get-Date)-$os.LastBootUpTime).Minutes} 
```

### # Long Script

```powershell
Clear-Host

$OS = Get-CimInstance Win32_OperatingSystem
$BootTime = $OS.LastBootUpTime
$Uptime = (Get-Date) - $BootTime

[PSCustomObject]@{
    ComputerName = $OS.CSName
    # "hh" = 12-hour, "mm" = minutes, "tt" = AM/PM
    LastBootTime = $BootTime.ToString("MM/dd/yyyy hh:mm tt")
    Uptime       = "{0}d {1}h {2}m" -f $Uptime.Days, $Uptime.Hours, $Uptime.Minutes
}
```

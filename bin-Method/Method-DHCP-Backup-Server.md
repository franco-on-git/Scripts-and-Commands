# Method: DHCP Backup Scopes

> [!IMPORTANT]
> - Must have **DHCP Server Tool** installed for `backup-dhcpserver` cmdlet to work.

```powershell
clear-host

# Scriptname
$ScriptName = "DHCP_Backup"

# AM or PM time indicator for file and folders naming
$AmOrPm = Get-Date -UFormat %p
If ($AmOrPm -eq 'AM') {$AmPM = "am"}
ElseIf ($AmOrPm -eq 'PM') {$AmPM = "pm"}

# Script home folder name and directory
$ScriptNameFull = "$env:COMPUTERNAME - $ScriptName - $(Get-Date -f MM_dd_yyyy_hhmm)$AmPM"
$ScriptFolder = "C:\DHCPBackup\$ScriptNameFull"

$null = New-Item -Path $ScriptFolder -ItemType directory

# -----------------------------------------------------------------

# Run DHCP backup
Backup-DhcpServer -Path $ScriptFolder
```
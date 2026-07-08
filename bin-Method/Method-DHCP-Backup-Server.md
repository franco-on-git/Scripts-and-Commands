# Method: DHCP Backup Scopes

> [!IMPORTANT]
> Must have **DHCP Server Tools** installed for `backup-dhcpserver` cmdlet to work.

```powershell
clear-host

# Name Variables
$ScriptName = "DHCP_Backup"
$BackupsDir = "C:\DHCPBackup"

if(!(Test-Path -Path $BackupsDir)) {$null = new-item -ItemType Directory -Path "C:\DHCPBackup"}

# -----------------------------------------------------------------

Write-Host "Creating Home folder.."

# AM or PM time indicator for file and folders naming
$AmOrPm = Get-Date -UFormat %p
If ($AmOrPm -eq 'AM') {$AmPM = "am"}
ElseIf ($AmOrPm -eq 'PM') {$AmPM = "pm"}

# Script home folder name and directory
$ScriptNameFull = "$env:COMPUTERNAME - $ScriptName - $(Get-Date -f MM_dd_yyyy_hhmm)$AmPM"
$ScriptFolder = "$BackupsDir\$ScriptNameFull"

$null = New-Item -Path $ScriptFolder -ItemType directory

Write-Host "Done" -ForegroundColor Green

Start-Sleep -Seconds 2

# -----------------------------------------------------------------

# Run DHCP backup
Write-Host "Running DHCP backup.."
Backup-DhcpServer -Path $ScriptFolder
Write-Host "Done" -ForegroundColor Green

Start-Sleep 2

# -----------------------------------------------------------------

# Zip new compressed file

Write-Host "Zipping up folder.." 
$ScriptFolderZip = "$ScriptFolder.zip"
Compress-Archive -Path $ScriptFolder -DestinationPath "$ScriptFolderZip"
Write-Host "Done" -ForegroundColor Green

Invoke-Item $BackupsDir


```

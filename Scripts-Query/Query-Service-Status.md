# Query System Service Status

> [!WARNING]
> - **<ins>Administrator</ins> Terminal required!**

> [!NOTE]
> - Queries CPU load over a 30 second time interval. 

```powershell
Clear-Host

$service = Read-Host "Service Name"

Get-Service -Name $service| Select-Object @{Name="ServerName"; Expression={$env:COMPUTERNAME}}, Status, Name, DisplayName | Format-Table -AutoSize

```
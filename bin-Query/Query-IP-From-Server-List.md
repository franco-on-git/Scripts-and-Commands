# Query: IP from Server
## Single Query
```powershell
$servers = "pnn0114b9"
foreach ($server in $servers) {Test-NetConnection $server | Select-Object computername,remoteaddress}
```
<br>


## List Query
```powershell
$servers = Get-Content C:\LOCAL\ServerList.txt
foreach ($server in $servers) {Test-NetConnection $server | Select-Object computername,remoteaddress | Export-Csv .\IPexport.csv -Append}
```
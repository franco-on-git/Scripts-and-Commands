# ----------------------------------------------------------------------------------
# SINGLE, QUICK QUERY
$servers = "pnn0114b9"
foreach ($server in $servers) {Test-NetConnection $server | Select-Object computername,remoteaddress}


# ----------------------------------------------------------------------------------
# QUERY FROM LIST
$servers = Get-Content C:\LOCAL\ServerList.txt
foreach ($server in $servers) {Test-NetConnection $server | Select-Object computername,remoteaddress | Export-Csv .\IPexport.csv -Append}



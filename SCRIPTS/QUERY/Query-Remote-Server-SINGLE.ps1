# Remote query using ScirptBlock
Invoke-Command -ComputerName servername -ScriptBlock {$env:COMPUTERNAME; (Get-NetIPAddress | Where-Object {$_.addressfamily -ne "IPv6" -and $_.IPAddress -like "10.*"}).IPAddress; quser}  


# ----------------------------------------------------------------------------------
# Remote query using ScirptBlock
Invoke-Command -ComputerName servername -ScriptBlock {$env:COMPUTERNAME; (Get-NetIPAddress | Where-Object {$_.addressfamily -ne "IPv6" -and $_.IPAddress -like "10.*"}).IPAddress; quser}  


# ----------------------------------------------------------------------------------
# Using single quotes to replace doubles, to escape CMD and POWERSHELL properly
# - In PowerShell, you can use single quotes ' inside a double-quoted string to avoid escaping.
# - The original command used Name="FreeGB" which caused confusion for the parser because of the nested double quotes.
# - Replacing " with ' inside the @{} has resolved the ambiguity.
cmd.exe /c echo . | powershell.exe -ExecutionPolicy Bypass -command "Get-PSDrive -Name C | Select-Object Name,@{Name='FreeGB';Expression={[math]::round($_.Free/1GB,2)}}"


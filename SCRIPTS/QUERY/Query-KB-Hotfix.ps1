# ----------------------------------------------------------------------------------
# Get All hot fixes from newest to oldest 
Get-HotFix | Sort-Object InstalledOn -Descending 

# ----------------------------------------------------------------------------------
# Search for specific patch\kb 
Get-HotFix | Where-Object {$_.hotfixid -eq "KB2919355"} 
Get-HotFix | Where-Object {$_.hotfixid -like "*19355*"} 
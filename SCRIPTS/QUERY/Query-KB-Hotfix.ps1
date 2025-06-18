# ----------------------------------------------------------------------------------
# Get All hot fixes from newest to oldest 
Get-HotFix | Sort-Object InstalledOn -Descending 

# ----------------------------------------------------------------------------------
# Search for SPECIFIC patch\kb 
Get-HotFix | Where-Object {$_.hotfixid -eq "KB2919355"} | Select-Object @{E={$_.csname};L="Server"},Description,HotFixID,Installedby,InstalledOn 

# Search for any (LIKE) patch\KB matching string
Get-HotFix | Where-Object {$_.hotfixid -like "*1577*"} | Select-Object @{E={$_.csname};L="Server"},Description,HotFixID,Installedby,InstalledOn 
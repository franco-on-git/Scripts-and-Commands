# ----------------------------------------------------------------------------------
# Get All hot fixes from newest to oldest 
Get-HotFix | Sort-Object InstalledOn -Descending 

# ----------------------------------------------------------------------------------
# Search for any (LIKE) patch\KB matching string
$hotfixID = "KB5060526" # ..Change me

$HotFixQuery = Get-HotFix | Where-Object {$_.hotfixid -like "*$hotfixID*"}

If ($HotFixQuery) {Get-HotFix | 
                   Where-Object {$_.hotfixid -like "*$hotfixID*"} | 
                   Select-Object @{E={$_.csname};L="Server"},HotFixID,Installedby,InstalledOn}

Else {write-host "$hotfixID Not Found" -ForegroundColor Yellow}
# Query: KB Patches / HotFix 

> [!NOTE]
> - 2 optional scripts to query for installed hotfixes
> - No <ins>Admin</ins> console required.

## Get <ins>All</ins> installed Hot Fixes:
```powershell
Get-HotFix | Sort-Object InstalledOn -Descending 
```

## Search patch\KB <ins>MATCHING</ins> string:
```powershell
cls

$hotfixID = Read-Host "KB Number"   # ..Change me

# Query for matching hotfix
$HotFixQuery = Get-HotFix | Where-Object {
    $_.hotfixid -like "*$hotfixID*"
}

# Display results if found
if ($HotFixQuery) {
    Write-Host "KB Found.." -ForegroundColor Green

    Get-HotFix |
        Where-Object {
            $_.hotfixid -like "*$hotfixID*"
        } |
        Select-Object @{
            E = { $_.csname }
            L = "Server"
        }, HotFixID, InstalledBy, InstalledOn
}
else {
    Write-Host "$hotfixID Not Found" -ForegroundColor Yellow
}
```

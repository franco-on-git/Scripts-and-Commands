# ----------------------------------------------------------------------------------
# Get All hot fixes from newest to oldest 
Get-HotFix | Sort-Object InstalledOn -Descending 


# ----------------------------------------------------------------------------------
# Search for any (LIKE) patch\KB matching string
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
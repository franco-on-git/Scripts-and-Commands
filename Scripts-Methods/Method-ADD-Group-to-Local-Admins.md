# Add Group to Local Administrators Group

### Copy Code:
```
Clear-Host

$groupaddition = read-host "Group To Be Added"

# Add group to local administrator
Add-LocalGroupMember -Group "Administrators" -Member "$groupaddition" -ErrorAction SilentlyContinue

# Verify that the group has been added to the the local admins group
$CCTVSecAdd = Get-LocalGroupMember -Group "Administrators" | Where-Object {$_.name -eq "$groupaddition"}
If ($CCTVSecAdd) {Write-Host "$groupaddition group successfully added!" -ForegroundColor Green
                  }
Else {write-host "Something went wrong, may need to add manually!" -ForegroundColor Red}
```

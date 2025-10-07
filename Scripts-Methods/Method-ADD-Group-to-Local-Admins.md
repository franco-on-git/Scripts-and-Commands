# Add Group to Local Administrators Group

### Copy Code:
```
Clear-Host

# Prompt for group name
$groupaddition = Read-Host "Group To Be Added"

# Add group to local administrators
Add-LocalGroupMember -Group "Administrators" -Member "$groupaddition" -ErrorAction SilentlyContinue

# Verify that the group has been added to the local admins group
$newgroupverify = Get-LocalGroupMember -Group "Administrators" | Where-Object { $_.Name -eq "$groupaddition" }

if ($newgroupverify) {
    Write-Host "$newgroupverify group successfully added!" -ForegroundColor Green
} else {
    Write-Host "Something went wrong, may need to add manually!" -ForegroundColor Red
}
```

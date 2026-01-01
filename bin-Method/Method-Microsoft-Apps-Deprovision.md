# Microsoft Apps: Deprovision and Remove

## Package Query

### Get list of of provisioned packages:
```powershell
Get-AppxProvisionedPackage -Online | Format-Table displayname,packagename
```

## Package removal

### Remove package from current/existing users:
```powershell
Get-AppxPackage -AllUsers -Name "PackageName" | Remove-AppxPackage -AllUsers
```

### Remove pacakge for furture users:
```powershell
Remove-AppxProvisionedPackage -Online -PackageName "PackageName"
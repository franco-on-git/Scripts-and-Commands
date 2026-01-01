# Microsoft Apps: Deprovision and Remove

### Query list of provisioned apps
```powershell
Get-AppxProvisionedPackage -Online | Format-Table displayname,packagename
```


### Remove pacakge 
```powershell
Remove-AppxProvisionedPackage -Online -PackageName "PackageName"
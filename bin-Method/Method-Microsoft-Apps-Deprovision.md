# Microsoft Apps: Deprovision and Remove

## Package Query

### Get list of of provisioned packages:
```powershell
Get-AppxProvisionedPackage -Online | Format-Table displayname,packagename
```

## Package removal (Single)
> [!WARNING]
> - <ins>Administrator</ins> terminal required!>

### Remove package from current/existing users:
```powershell
Get-AppxPackage -AllUsers -Name "PackageName" | Remove-AppxPackage -AllUsers
```

### Remove package for furture users:
```powershell
Remove-AppxProvisionedPackage -Online -PackageName "PackageName"
```

## Package Removal (Script)
```powershell
Clear-Host

# ==========================================
# LOGIC BLOCK 1: Discovery & Input
# ==========================================

# Get list of provisioned packages
Get-AppxProvisionedPackage -Online | Format-Table displayname, packagename

Write-Host ""

$packageyeet = Read-Host "Package to remove"

# Check if package exists based on input
$packageexist = Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -eq $packageyeet }

# ==========================================
# LOGIC BLOCK 2: Execution Flow
# ==========================================

If ($packageexist) {
    # Notify user of confirmation
    Write-Host "Package Exists: $($packageexist.displayname)" -ForegroundColor Cyan
    Write-Host ""

    # Step A: Remove from Provisioned (Future Users)
    Write-Host "Removing package from future users..." -ForegroundColor Yellow
    $null = Remove-AppxProvisionedPackage -Online -PackageName $packageexist.PackageName
    
    Write-Host ""

    # Step B: Remove from Appx (Current Users)
    # Note: Retained original string value including spelling
    Write-Host "Removing pacakage from current/existing users..." -ForegroundColor Yellow
    $null = Get-AppxPackage -AllUsers -Name $packageexist.PackageName | Remove-AppxPackage -AllUsers

    Write-Host ""

    # ==========================================
    # LOGIC BLOCK 3: Verification
    # ==========================================
    
    Write-Host "Verifying package is no longer active..." -ForegroundColor Yellow
    $packagefollowup = Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -eq $packageyeet }

    If (!$packagefollowup) {
        Write-Host ""
        Write-Host "Package successufully removed!" -ForegroundColor Cyan
    }
    Else {
        Write-Host ""
        Write-Host "Package $($packagefollowup.displayname) still exists!" -ForegroundColor Yellow
    } 
}
Else {
    # Fallback if initial input provided no matches
    Write-Host "Package does not exist!" -ForegroundColor Yellow
}
```



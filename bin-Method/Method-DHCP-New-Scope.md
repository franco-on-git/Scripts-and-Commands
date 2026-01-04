
# Method: New DHCP Scope
> [!WARNING]
> <ins>Administrator</ins> Terminal required!


```powershell
Clear-Host

# New scope variables
$scopename  = Read-Host "Scope Name"
$startrange = Read-host "Start Range"
$endrange   = Read-Host "End Range"
$router     = Read-Host "Router"
$submask    = Read-Host "Subent Mask"

write-host ""

# Checking if scope exists
write-host "Checking if scopes exists..." -ForegroundColor Cyan
$ExistingScope = Get-DhcpServerv4Scope | Where-Object { $_.StartRange -eq $StartRange }
Write-Host ""

if ($ExistingScope) {
    #Existing scope found, display info
    Write-Host "Scope exists..." -ForegroundColor Yellow
    write-host "Scope Name: $($ExistingScope.name)"
    Write-Host "Scope ID: $($ExistingScope.ScopeId)"
    Write-Host "Start Range: $($ExistingScope.StartRange)"
    Write-Host "Start Range: $($ExistingScope.endrange)"
    
} else {Write-Host "Creating new scope..." -ForegroundColor Cyan
        # Creating new scope
        Add-DhcpServerv4Scope -Name $scopename -StartRange $startrange -EndRange $endrange -optionID 3 -value $router -SubnetMask $submask -LeaseDuration 0.08:00:00
}
```

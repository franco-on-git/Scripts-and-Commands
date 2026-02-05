# DHCP Queries

## Scope Name String-Based Search
```powershell
Clear-Host

$searchString = Read-Host "DHCP Scope String Search"

# Added -ComputerName for remote targeting
Get-DhcpServerv4Scope | 
    Where-Object { $_.Name -like "*$searchString*" } | 
    Sort-Object Name | 
    Format-Table -AutoSize
```

<br>

## High-Utilizaiton Scopes
```powershell
Clear-Host

Get-DhcpServerv4ScopeStatistics | Where-Object { $_.PercentageInUse -ge 98 } | ForEach-Object {
    $ScopeDetails = Get-DhcpServerv4Scope -ScopeId $_.ScopeId
    
    [PSCustomObject]@{
        ScopeName      = $ScopeDetails.Name
        ScopeId        = $_.ScopeId
        SubnetMask     = $ScopeDetails.SubnetMask
        Free           = $_.Free
        InUse          = $_.InUse
        'PercentInUse(%)' = [int]$_.PercentageInUse
        Reserved       = $_.Reserved
    }
} | Format-Table -AutoSize
```

<br>


## MAC-Based Search
- Use hyphens (`-`) rather than colons (`:`) in the MAC address for this query.

```powershell
Clear-Host

# Read user entry
$userInput = Read-Host "Enter your string"

# Remove any ":" or spaces
# We use a regex character class [ : ] to find both colons and spaces
$sanitized = $userInput -replace '[: ]', ''

# Logic: If no "-" exists, add a hyphen every 2 characters
if ($sanitized -notlike "*-*") {
    # Match any 2 characters and append a hyphen
    # .TrimEnd('-') ensures no hyphen is left at the very end
    $result = ($sanitized -replace '(.{2})', '$1-').TrimEnd('-')
} else {
    $result = $sanitized
}

# Query DHCP for MAC string
Get-DhcpServerv4Scope | Get-DhcpServerv4Lease | Where-Object {$_.ClientId -eq $result}
```

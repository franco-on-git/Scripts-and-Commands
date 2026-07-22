# DHCP Queries

## Scope Seach by "Name" string (Nested Objects!)
```powershell
Clear-Host

$searchString = Read-Host "DHCP Scope String Search"

# 1. Store the filtered scopes into a variable first
$scopes = Get-DhcpServerv4Scope | Where-Object { 
    $_.Name -match "$searchString" -or $_.ScopeId -match "$searchString" 
}

# 2. Check if the variable contains any data
if ($null -eq $scopes) {
    Write-Host "`n$($searchString) Not Found!" -ForegroundColor Red
}
else {
    # 3. Process the scopes if they exist
    $scopes | ForEach-Object {
        # Fetch live stats for the current scope
        $stats = Get-DhcpServerv4ScopeStatistics -ScopeId $_.ScopeId
        
        [PSCustomObject]@{
            ScopeID        = $_.ScopeId
            SubnetMask     = $_.SubnetMask
            Name           = $_.Name
            State          = $_.State
            StartRange     = $_.StartRange
            EndRange       = $_.EndRange
            TotalUsableIPs = $stats.InUse + $stats.Free
            Reserved       = $stats.Reserved
            InUse          = $stats.InUse
            Free           = $stats.Free
            'InUse (%)'    = [int][math]::Round($stats.PercentageInUse)
        }
    } | 
    Sort-Object { [version]$_.ScopeID.IPAddressToString } | 
    
    # Using Format-Table cuts out the last row due to character limitation on screen
    Out-GridView 
}


<#
    - The Conversion: $_.ScopeID.IPAddressToString turns the complex IP object into a simple text format like "10.33.49.0".
    - The [version] Cast: By wrapping that string in [version], PowerShell treats it as a four-part number (Major.Minor.Build.Revision), ensuring 10.33.49.0 correctly ranks before 10.33.222.0.
    - Result: You get a perfectly ordered list by IP address without any "string-based" sorting errors. 
#>
```

<br>

## High-Utilization Scopes (>90%)
```powershell
# Clear the console for a clean output view
Clear-Host

# Retrieve DHCP scope statistics and filter scopes at or above 90% utilization
Get-DhcpServerv4ScopeStatistics |
    Where-Object { $_.PercentageInUse -ge 90 } |
    ForEach-Object {

        # Fetch full scope details (e.g., name) using the current scope ID
        $ScopeDetails = Get-DhcpServerv4Scope -ScopeId $_.ScopeId

        # Construct a structured output object for each qualifying scope
        [PSCustomObject]@{
            ScopeName      = $ScopeDetails.Name
            ScopeId        = $_.ScopeId
            TotalUsableIPs = $_.InUse + $_.Free
            InUse          = $_.InUse
            Free           = $_.Free
            'InUse (%)'    = [int]$_.PercentageInUse
        }

    } |
    # Sort results by utilization percentage, highest first
    Sort-Object -Property 'InUse (%)' -Descending |
    # Display the final results in a formatted, auto-sized table
    Format-Table -AutoSize
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

br>


## BAD_ADRESS Search (ALL)
- Use hyphens (`-`) rather than colons (`:`) in the MAC address for this query.

```powershell
 #Requires -Module DhcpServer

<#
.SYNOPSIS
    Retrieves DHCP leases where the hostname contains the prefix "BAD_".

.DESCRIPTION
    Clears the host console, then queries all DHCPv4 scopes on the local DHCP
    server, retrieves all active leases, and filters for any lease whose hostname
    matches the pattern "BAD_". Results are sorted by Name and displayed with
    Format-Table -AutoSize for easy review.

.OUTPUTS
    PSCustomObject with properties: Name, ScopeId, IPAddress, ClientId, HostName

.NOTES
    Author      : Systems Administration
    Version     : 1.2.0
    Requires    : DhcpServer PowerShell module (RSAT or Windows Server role)
    Permissions : Must be run with DHCP Administrator or equivalent privileges
#>

Clear-Host

$scopes = Get-DhcpServerv4Scope

$scopes |
    Get-DhcpServerv4Lease |
    Where-Object -FilterScript { $_.HostName -match 'BAD_' } |
    Select-Object -Property @{ Name = 'Name'; Expression = { ($scopes | Where-Object ScopeId -EQ $_.ScopeId).Name } },
                            ScopeId,
                            IPAddress,
                            ClientId,
                            HostName |
    Sort-Object -Property Name |
    Format-Table -AutoSize
```


<br>


## BAD_ADRESS Search (COUNT TOTAL)
- Use hyphens (`-`) rather than colons (`:`) in the MAC address for this query.

```powershell
cls
Get-DhcpServerv4Scope |
    Get-DhcpServerv4Lease |
    Where-Object { $_.HostName -eq "BAD_ADDRESS" } |
    Group-Object ScopeId |
    Select-Object Name, Count |
    Sort-Object Name
```





# Query: DHCP MAC-Based Search
- Use hyphens (`-`) rather than colons (`:`) in the MAC address for this query.

```powershell
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
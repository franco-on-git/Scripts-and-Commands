# Query AD OU for **SERVER** objects

> [!WARNING]
> - Must run query in server with **AD Directory Services** installed.

> [!NOTE]
> - Queries Active Directory for all server objects in Organizational Unit.

## Query for quick on-screen results:
```
(Get-ADObject -Server domain.com -SearchBase "OU=Name,OU=Name,DC=Domain,DC=com" -Filter * -Properties *).CN 
```

## Query and Export to CSV:
```
# Define paths
$OUPath      = "OU=Name,OU=Name,DC=Domain,DC=Domain,DC=com"
$ExportPath  = "C:\temp\OU_Export.csv"

# Query AD and export CNs to CSV
Get-ADObject -Server domain.com `
             -SearchBase $OUPath `
             -Filter * `
             -Properties CN |
    Select-Object -ExpandProperty CN |
    Sort-Object |
    Export-Csv -Path $ExportPath -NoTypeInformation -Force

# Open the exported file
Invoke-Item $ExportPath
```

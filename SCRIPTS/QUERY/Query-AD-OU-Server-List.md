# Query AD OU for **SERVER** objects

> [!WARNING]
> - Must run query in server running **Active Directory - Directory Services**

> [!NOTE]
> - Queries Active Directory for all server objects in Organizational Unit

## Query for quick on-screen results
```
(Get-ADObject -Server domain.com -SearchBase "OU=Name,OU=Name,DC=Domain,DC=Domain,DC=com" -Filter * -Properties *).CN | Sort-Object 
```

## Query and Export to CSV
```
$OUPath = "OU=Name,OU=Name,DC=Domain,DC=Domain,DC=com" 
$ExportPath = "C:\temp\OU_Export.csv" 

Get-ADObject -Server domain.com -SearchBase $OUPath -Filter * -Properties * | Select-Object CN | Export-Csv $ExportPath -NoTypeInformation -Force

Invoke-Item $ExportPath
```

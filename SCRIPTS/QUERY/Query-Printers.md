# Query Printers

> [!NOTE]
> - Query system for locally installed and/or network printers.

## Printers (Local Only and excluding XPS/PDF)
```
Clear-Host

# Save all local printers to variable, excluding xps, pdf, fax, and onenote
$Printers = Get-Printer | Where-Object {
    $_.Type -eq 'Local' -and 
    $_.Name -notmatch 'xps|pdf|fax|onenote'
}

# Check if any printers were found and display appropriate result
if ($Printers) {$Printers | Format-Table Name, DriverName, PortName -AutoSize}
else {Write-Host "No printers found."}
```

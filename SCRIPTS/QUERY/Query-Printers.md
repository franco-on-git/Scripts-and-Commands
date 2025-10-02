# Query Printers

> [!NOTE]
> - Query system for locally installed and/or network printers.

## Printers (Local Only and excluding XPS/PDF)
```
Clear-Host

# Save all local printers to a variable, excluding XPS and PDF ones
$Printers = Get-Printer | Where-Object {
    $_.Type -eq 'Local' -and
    $_.Name -notlike '*xps*' -and
    $_.Name -notlike '*pdf*'
}

# Check if any printers were found and display appropriate result
if ($Printers) {
    Write-Host "Printer Mappings Found:`n"

    # Display printer info in a readable table format
    $Printers | Format-Table Name, DriverName, PortName -AutoSize
}
else {
    Write-Host "No printers found."
}
```

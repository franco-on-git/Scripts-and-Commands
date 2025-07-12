<#
    .NOTES
        Author: Franco-hq
        Created: 09/2024

    .SYNOPSIS
        Query local system for installed printers.

    .DESCRIPTION
        1. Creates a variable that queries for all locally installed printers excluding "XPS" and "PDF".
        2. Checks if any printers are installed or if the result is $null, and shows an appropriate message.
#>


# Save all printers to a variable, excluding XPS and PDF ones.
$Printers = Get-Printer | Where-Object {
    $_.Name -notlike "*xps*" -and $_.Name -notlike "*pdf*"
}

# Check if any printers were found and display appropriate result
if ($null -ne $Printers) {
    Write-Host "Printer Mappings Found:"

    # Display printer info in a readable table format
    $Printers | Format-Table Name, DriverName, PortName -AutoSize
}
else {
    Write-Host "No Printers found"
}
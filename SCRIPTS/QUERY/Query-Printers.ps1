<#
    .NOTES
        Author: Franco-hq
        Created: 09/2024

    .SYNOPSIS
        Query local system for installed printers.

    .DESCRIPTION
        - Creates a variable that queries for all locally installed printers, excluding "XPS" and "PDF".
        - Checks if any printers are installed and displays the appropriate result.
        - Omit pipe from line 17 and 18 if you want all printers displayed, including "XPS" and "PDF".
        
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
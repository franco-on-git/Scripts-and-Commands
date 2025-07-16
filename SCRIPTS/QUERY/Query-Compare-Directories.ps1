<#
    .NOTES
        Author: Franco-hq
        Created: 07/25

    .SYNOPSIS
        Compare 2 diffrent directories for file diffrences

    .DESCRIPTION
        - Compares and displays all the diffrent directories between 2 folders.
        - Displays how many are diffrent in each target.
        - Finishes by displaying how many unique subdirectories are in total.
        
#>


clear-host
$dir1 = "<directory1>"
$dir2 = "<directory2>"

# Get relative paths of subdirectories
$subs1 = Get-ChildItem -Path $dir1 -Recurse -Directory | ForEach-Object {
    $_.FullName.Replace($dir1, "").TrimStart("\").ToLower()
}
$subs2 = Get-ChildItem -Path $dir2 -Recurse -Directory | ForEach-Object {
    $_.FullName.Replace($dir2, "").TrimStart("\").ToLower()
}

# Compare sets
$onlyIn1 = $subs1 | Where-Object { $_ -notin $subs2 }
$onlyIn2 = $subs2 | Where-Object { $_ -notin $subs1 }

# Show results
Write-Host "Subdirectories only in $dir1 $($onlyIn1.Count)"
$onlyIn1 | ForEach-Object { Write-Host " → $_" }
Write-Host ""

Write-Host "Subdirectories only in $dir2 $($onlyIn2.Count)"
$onlyIn2 | ForEach-Object { Write-Host " → $_" }
Write-Host ""

Write-Host "Total unique subdirectories: $($onlyIn1.Count + $onlyIn2.Count)"
Write-Host ""
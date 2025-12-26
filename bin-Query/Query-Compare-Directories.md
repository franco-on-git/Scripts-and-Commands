# Query: Compare Directories for Contents

> [!NOTE]
> - Compare 2 diffrent directories for object (File/Folder) diffrences.
> - Displays what objects exists whithin each directory.
> - Finishes by display what objects are located in both directories
        
## Copy Code:

```powershell
clear-host

Add-Type -AssemblyName System.Windows.Forms

function Select-Folder($prompt) {
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = $prompt
    $dialog.ShowNewFolderButton = $true

    if ($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $dialog.SelectedPath
    } else {
        return $null
    }
}

# Prompt for source and target folders
$SourceDir = Select-Folder "Select the SOURCE folder"
$TargetDir = Select-Folder "Select the TARGET folder"

if (-not $SourceDir -or -not $TargetDir) {
    Write-Host "Folder selection cancelled. Exiting script." -ForegroundColor Red
    return
}

Write-Host "`nComparing files in:`n$SourceDir`n$TargetDir`n"

# Recursively get relative file paths
$SourceFiles = @(Get-ChildItem -Path $SourceDir -Recurse -File | ForEach-Object {
    $_.FullName.Replace($SourceDir, '').TrimStart('\')
})
$TargetFiles = @(Get-ChildItem -Path $TargetDir -Recurse -File | ForEach-Object {
    $_.FullName.Replace($TargetDir, '').TrimStart('\')
})

if ($SourceFiles.Count -eq 0 -and $TargetFiles.Count -eq 0) {
    Write-Host "Both folders are empty. Nothing to compare." -ForegroundColor DarkYellow
    return
}

# Compare file lists
$OnlyInSource = Compare-Object $SourceFiles $TargetFiles -PassThru | Where-Object { $_ -in $SourceFiles }
$OnlyInTarget = Compare-Object $SourceFiles $TargetFiles -PassThru | Where-Object { $_ -in $TargetFiles }
$InBoth       = $SourceFiles | Where-Object { $TargetFiles -contains $_ }

# Output results
Write-Host "`Objects in $SourceDir only:" -ForegroundColor Cyan
if ($OnlyInSource) { $OnlyInSource | ForEach-Object { Write-Host $_ } } else { Write-Host "None" }

Write-Host "`nObjects in $TargetDir only:" -ForegroundColor Yellow
if ($OnlyInTarget) { $OnlyInTarget | ForEach-Object { Write-Host $_ } } else { Write-Host "None" }

Write-Host "`nObjects present in BOTH directories:" -ForegroundColor Green
if ($InBoth) { $InBoth | ForEach-Object { Write-Host $_ } } else { Write-Host "None" }
```

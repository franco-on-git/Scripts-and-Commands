> [!NOTE]
> - Deletes Files, Folders, and Sub-Folders from a specified directory.

## PowerShell
```
Get-ChildItem -Path [direcitory] -Include *.* -File -Recurse | ForEach-Object { $_.Delete()}
```

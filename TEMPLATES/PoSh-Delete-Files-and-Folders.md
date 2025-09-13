

# Deletes Files, Folders, and Sub-Folders from a specified directory.
```
Get-ChildItem -Path [direcitory] -Include *.* -File -Recurse | ForEach-Object { $_.Delete()}
```

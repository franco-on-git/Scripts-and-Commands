# DELETES FILES, FOLDERS, AND SUBFOLDERS
Get-ChildItem -Path [direcitory] -Include *.* -File -Recurse | ForEach-Object { $_.Delete()}
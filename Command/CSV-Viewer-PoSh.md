# CSV Viewer using PowerShell

> [!NOTE]
> - Imports CSV file into Powershell and outputs results.
> - Choose betwen quick on screen display or export list.

## GridView Display:
```
Import-Csv yourfile.csv | Out-GridView
```
## Console Display:
```
Import-Csv yourfile.csv | Format-Table -AutoSize
```
or:
```
Import-Csv yourfile.csv | Format-List 
```

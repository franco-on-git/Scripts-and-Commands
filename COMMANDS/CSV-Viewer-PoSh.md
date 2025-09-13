# GridView Display:
```
Import-Csv yourfile.csv | Out-GridView
```
# Console Display:
```
Import-Csv yourfile.csv | Format-Table -AutoSize
```
or:
```
Import-Csv yourfile.csv | Format-List 
```

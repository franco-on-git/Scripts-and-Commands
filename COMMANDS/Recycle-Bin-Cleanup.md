## INFORMATIONAL
- Created: 10/2024
- Cleans up drive reycle bin
- The `$recycle.bin` directory is a hidden system directory
- Command empties the recycling bin for all users on a Windows computer
- The Clear-RecycleBin cmdlet deletes the content of the current user's recycle bin. This action is like using Windows Empty Recycle Bin.
- Source | https://stackoverflow.com/questions/4967496/check-if-a-windows-service-exists-and-delete-in-powershell      

## COMMAND PROMPT
Clears all recycle bins (CMD Admin required)
```
rm /s c:\$Recycle.Bin 
```

## POWERSHELL
Clears recycle bin for current user (Powershell 7)
```
Clear-RecycleBin -force
```

Clears recycle bing for system drive
```
Clear-RecycleBin -DriveLetter C
```

Clears recycle bin for all drives, no prompt
```
Clear-RecycleBin -Forcej
```

# Recycle Bin Cleanup

> [!WARNING]
> **<ins>Administrator</ins> Terminal Required!**

# Informational
- Cleans up drive reycle bin
- The `$recycle.bin` directory is a hidden system directory
- Command empties the recycling bin for all users on a Windows computer
- The Clear-RecycleBin cmdlet deletes the content of the current user's recycle bin. This action is like using Windows Empty Recycle Bin.
- Source | [StackOverflow](https://stackoverflow.com/questions/4967496/check-if-a-windows-service-exists-and-delete-in-powershell)

## Command-Line (CMD)
Clears `C:\` drive Recycle Bin
```batch
rm /s c:\$Recycle.Bin 
```

## PowerShell (cmdlet)
Clears recycle bin for all drives, no prompt.
```powershell
Clear-RecycleBin -Force
```

Clears recycle bin for `C:\` drive.
```powershell
Clear-RecycleBin -DriveLetter C
```



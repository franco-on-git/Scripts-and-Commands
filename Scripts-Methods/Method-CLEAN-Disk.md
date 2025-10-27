# Clean System Disks (Disk Cleanup)

<br> 

- Built-in Windows tool (Disk Cleanup) that helps free up space by removing unnecessary files like:
  - Temporary files
  - Recycle Bin Contents
  - System error memory dumps
  - Windows Update Leftovers
  - Thumbnail and cached files
  - System logs
  - Old updates.

<br>

Copy code:
```shell
cleanmgr.exe
```

<br>

Target a specific drive:
```shell
cleanmgr.exe /d
```

<br>

Automatically deletes the files that are left behind after you upgrade Windows:
```shell
cleanmgr.exe /autoclean
```
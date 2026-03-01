# Robocopy

> [!WARNING]
> **<ins>Administrator</ins> Terminal required!**

 
## Switches:
| **Switch** | **Description** |
| :---  | :--- | 
| /e | Copies all subdirectories, including empty ones. | 
| /z | Enables restartable mode, useful for large files or network copies. |
| /r:0 | Sets the number of retries on failed copies to 0 (no retries). |
| /w:0 | Sets the wait time between retries to 0 seconds. |
| /MT:16 | Uses multi-threading with `16` threads (speeds up copying), default is `8` and max `128`. |
| /COPYALL  | Copies all file info: data, attributes, timestamps, security (ACLs), owner, auditing. |
| /eta | Displays the estimated time of arrival (completion) per file. |
| /LOG: | Logs output to C:\temp\robocopy.txt. Overwrites if file exists. |

<br>

## One-Time Migration with ACLs Preserverd:
```
robocopy "source" "destination" /E /ZB /R:3 /W:5 /MT:32 /COPYALL /DCOPY:DAT /LOG+:C:\temp\robocopy.txt /NP /NFL /NDL
```

<br>

## Mirror SOURCE to DESTINATION (deletes extra files in destination)
```
robocopy "source" "destination" /MIR /ZB /R:3 /W:5 /MT:32 /COPYALL /DCOPY:DAT /LOG+:C:\temp\robocopy.txt /NP /NFL /NDL
```
> [!WARNING]
> `/MIR` deletes files that don’t exist in source. Consider a dry-run first with `/L` (list only) to see what would be copied/deleted:
```
robocopy "source" "destination" /MIR /L /NP
```

<br>

## Copy Data Only (No security/owner/auditing)
```
robocopy "source" "destination" /E /Z /R:3 /W:5 /MT:32 /COPY:DAT /DCOPY:DAT /LOG+:C:\temp\robocopy.txt /NP /NFL /NDL /FFT
```






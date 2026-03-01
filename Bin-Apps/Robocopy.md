# ROBOCOPY

> [!WARNING]
> **<ins>Administrator</ins> Terminal required!**

<br>

## One-Time Migration with ACLs Preserverd (recommended):
```
robocopy "source" "destination" /E /ZB /R:3 /W:5 /MT:32 /COPYALL /DCOPY:DAT /LOG+:C:\temp\robocopy.txt /NP /NFL /NDL
```

## Mirror SOURCE to DESTINATION (deletes extra files in destination):
```
robocopy "source" "destination" /MIR /ZB /R:3 /W:5 /MT:32 /COPYALL /DCOPY:DAT /LOG+:C:\temp\robocopy.txt /NP /NFL /NDL
```
> [!WARNING]
> `/MIR` deletes files that don’t exist in source. Consider a dry-run first with `/L` (list only) to see what would be copied/deleted:
```
robocopy "source" "destination" /MIR /L /NP
```

## Copy Data Only (No security/owner/auditing):
```
robocopy "source" "destination" /E /Z /R:3 /W:5 /MT:32 /COPY:DAT /DCOPY:DAT /LOG+:C:\temp\robocopy.txt /NP /NFL /NDL /FFT
```

<br>

## Switches:
`/E`
- Copy every folder, including empty ones.
- If the folder exists in the source, it will exist in the destination.

`/ZB`
This is two modes combined:
- `/Z` (restartable mode): If the copy is interrupted (network blip, disconnect), it can resume where it left off instead of starting over.

- `/B` (backup mode): If a file is protected or you don’t have normal permission, robocopy tries again using backup privileges (works when running as admin).

- `/ZB` = Try restartable mode first, and if blocked, use backup mode.

`/R:3`
- If robocopy hits an error copying a file (like it's locked), it will retry 3 times.

`/W:5`
- When a retry is needed, robocopy will wait 5 seconds before trying again.

`/MT:32`
- Use 32 parallel copying threads (like 32 workers).
- This makes copying much faster, especially for lots of small files.

`/COPYALL`
- Copy everything associated with a file:
  - The file’s data
  - File attributes
  - Timestamps
  - Security permissions
  - Ownership
  - Auditing info

- Basically: make an exact clone with all details preserved.

`/DCOPY:DAT`
- Copy directory:
  - Data
  - Attributes
  - Timestamps

- This ensures folders themselves keep their original dates and attributes, not just the files.

`/LOG+:C:\temp\robocopy.txt`
- Write a log to the path given, but the + means:
  - Append to the log file
  - Don’t overwrite it each run
- This keeps a running history of your robocopy jobs.

`/NP`
- No Progress
- Stops robocopy from showing percentage progress for each file in the log.
- Makes the log cleaner and smaller.

`/NFL`
- No File List
- Robocopy won’t list every single file it copies.
- This also keeps the log tidy.

`/NDL`
- No Directory List
- Robocopy won’t list directories as it processes them.
- Makes the log short and focused on important info (errors, summary).





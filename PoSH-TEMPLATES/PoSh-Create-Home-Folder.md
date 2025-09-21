
> [!NOTE]
> - Generates `WINDOWS SUPPORT` folder on user's desktop
> - Creates folder to dump all results into, if required, from script or array.
> - Script uses `$env:userprofile` variable to taget the current user that is logged on.
> - `$AmOrPM` variable used to determine the time of day and will be added to directory name.

# PowerShell
```
# SCRIPTNAME
$ScriptName = "Name Me Please"


# AM OR PM TIME INDICATOR FOR FILE AND FOLDER NAMING PURPOSES
$AmOrPm = Get-Date -UFormat %p
If ($AmOrPm -eq 'AM') {$AmPM = "am"}
ElseIf ($AmOrPm -eq 'PM') {$AmPM = "pm"}


# SCRIPT HOME FOLDER NAME AND DIRECTORY
$ScriptNameFull = "$ScriptName - $(Get-Date -f MM_dd_yyyy_hhmm)$AmPM"
$ScriptFolder = "$env:userprofile\desktop\WINDOWS SUPPORT\$ScriptNameFull"

New-Item -Path $ScriptFolder -ItemType directory | Out-Null
```

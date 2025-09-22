> [!Note]
> - Paste at the top of the main script to automatically switch to elevated (privileged) terminal.

## Copy Code:
```
# Check if elevated
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $IsAdmin) {
    Write-Host "Not elevated. Relaunching as Administrator..."
    Start-Process powershell -Verb RunAs
    exit
} else {
    Write-Host "Running with Administrator privileges"
}

```

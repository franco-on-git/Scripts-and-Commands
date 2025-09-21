> [!Note]
> - Paste at the top of the main script to automatically switch to elevated (privileged) terminal.

# Copy Code:
```
# Check if currently session role is Administrator
$isAdmin = [System.Security.Principal.WindowsPrincipal]::new(
    [System.Security.Principal.WindowsIdentity]::GetCurrent()).
        IsInRole('Administrators')

#If Current session no Administrator, switch
if(-not $isAdmin) {
    $params = @{
        FilePath     = 'powershell' # or pwsh if Core
        Verb         = 'RunAs'
        ArgumentList = @(
            '-NoExit'
            '-ExecutionPolicy ByPass'
            '-File "{0}"' -f $PSCommandPath
        )
    }
    Start-Process @params
    return
}
#Write to host that the new session is Administrative
write-host "ADMINISTRATOR POWERSHELL" -ForegroundColor Cyan
```

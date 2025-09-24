> [!NOTE]
> - 2-scenario example that uses a variable to see if something is "$true" or not.
> - Powershell uses the `!` as a logical `-not` operator.
> - If used next to a variable, it would mean not `$TRUE` or non-existent.


## If Exists:
```
$processname = Get-Process [processname] -ErrorAction SilentlyContinue

if ($processname) {write-host "Process Exists"}
else {Write-Host "Process doesn't exist"}
```


## If does NOT Exist:
```
$processname = Get-Process [processname] -ErrorAction SilentlyContinue

if (!$processname) {Write-Host "Does not exist"}
else {Write-Host "Process Exists"}
```

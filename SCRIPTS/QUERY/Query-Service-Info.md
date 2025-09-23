# Query Service Information

> [!WARNING]
> - **Terminal: Run as <ins>Administrator</ins> required!**

> [!Note]
> - Queries service for uptime and status information

## Copy Code:
```
Clear-Host

$Process2Query = Read-Host "Process Name"

$ProcessInfo = Get-CimInstance -ClassName Win32_Service -Filter "Name='$Process2Query'" | ForEach-Object {
    $proc = Get-Process -Id $_.ProcessId -ErrorAction SilentlyContinue
    $uptime = if ($proc) {
        $ts = (Get-Date) - $proc.StartTime
        "{0}d {1}h {2}m" -f $ts.Days, $ts.Hours, $ts.Minutes
    } else {
        "N/A"
    }
    [PSCustomObject]@{
        Hostname    = $_.SystemName.ToUpper()  # Capitalize all letters
        PID         = $_.ProcessID.ToString("D")  # Removes comma formatting
        Name        = $_.Name
        State       = $_.State.ToUpper() # Capitalize all letters
        Uptime      = $uptime
        Description = $_.Description
    }
}

$ProcessInfo | Out-GridView
```

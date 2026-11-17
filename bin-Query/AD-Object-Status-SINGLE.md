# Active Directory Object Status (Server List)

> [!WARNING]
> - Must run in a session with the **ActiveDirectory** PowerShell module (RSAT / AD DS tools) installed.

> [!NOTE]
> - Reads the server list from ` $env:USERPROFILE\Desktop\server_list.txt` (one hostname per line). Edit the path at the top of the script if needed.
> - For each server, queries every DC in its domain and prints **only the Summary section** (Enabled, Operating system, Last logon, LastLogonTimestamp, PwdLastSet).
> - Output is saved to `Desktop\PsHOME\` as a TXT (screen copy) and a CSV (one row per server).

## Script:
```
Clear-Host

$thresholdDays = 30   # age text turns orange when older than this many days

# --------------------------
# Server list input
# --------------------------
$inputList = Get-Content " $env:USERPROFILE\Desktop\Desktop\server_list.txt"

$servers = $inputList | ForEach-Object { $_.Trim() } | Where-Object { $_ } | Select-Object -Unique

if (-not $servers) { Write-Host "No servers provided." -ForegroundColor Red; return }

# --------------------------
# Create Script home folder
# --------------------------
$ScriptName     = "Active Directory Search (Server List)"
$ScriptNameFull = "$ScriptName-$((Get-Date -Format 'MM_dd_yyyy_hhmmtt').ToLower())"
$ScriptFolder   = "$env:USERPROFILE\Desktop\PsHOME\$ScriptNameFull"
$null = New-Item -Path $ScriptFolder -ItemType directory -Force

$ResultsCSV = "$ScriptFolder\$ScriptNameFull-CSVResults.csv"
$ResultsTXT = "$ScriptFolder\$ScriptNameFull-TXTResults.txt"

# --------------------------
# Tee Write-Host to screen AND $ResultsTXT
# --------------------------
function Write-Host {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
        [object[]]$Object,
        [ConsoleColor]$ForegroundColor,
        [ConsoleColor]$BackgroundColor,
        [switch]$NoNewline,
        [object]$Separator = ' '
    )
    $text  = ($Object | ForEach-Object { "$_" }) -join $Separator
    $plain = $text -replace "$([char]27)\[[0-9;]*m", ''
    $plain = $plain -replace "(?<!`r)`n", "`r`n"
    Add-Content -Path $ResultsTXT -Value $plain -NoNewline:$NoNewline -Encoding UTF8
    Microsoft.PowerShell.Utility\Write-Host @PSBoundParameters
}

Add-Content -Path $ResultsTXT -Encoding UTF8 -Value @(
    "Servers  : $($servers.Count)"
    "Run by   : $env:USERDOMAIN\$env:USERNAME"
    "Run date : $(Get-Date -Format 'MM/dd/yyyy HH:mm:ss')"
    ('-' * 60)
)

# --------------------------
# Helpers
# --------------------------
function Convert-FT($v) {
    if ($v -and $v -ne 0 -and $v -ne 9223372036854775807) { [datetime]::FromFileTime($v) } else { $null }
}
function Show-Dt($d) { if ($d) { $d.ToString('MM/dd/yyyy HH:mm:ss') } else { 'Never / none on this DC' } }

function Write-Orange($text, [switch]$NoNewline) {
    if ($Host.UI.SupportsVirtualTerminal -and $Host.Name -eq 'ConsoleHost') {
        $esc = [char]27
        Write-Host "$esc[38;5;208m$text$esc[0m" -NoNewline:$NoNewline
    } else {
        Write-Host $text -ForegroundColor Yellow -NoNewline:$NoNewline
    }
}

function Get-Newest($prop) {
    $results | Where-Object { $_.$prop } | Sort-Object $prop -Descending | Select-Object -First 1
}

# Returns the newest value (and its source DC) and prints the summary line
function Show-Line($label, $prop) {
    $r = Get-Newest $prop
    if ($r) {
        $days = [math]::Round(((Get-Date) - $r.$prop).TotalDays, 1)
        Write-Host ("{0,-20}: {1}  " -f $label, (Show-Dt $r.$prop)) -NoNewline
        $age = "($days days ago, from $($r.DC))"
        if ($days -le $thresholdDays) { Write-Host $age } else { Write-Orange $age }
    } else {
        Write-Host ("{0,-20}: Never / none on any DC" -f $label) -ForegroundColor Yellow
    }
    $r
}

# --------------------------
# Main
# --------------------------
$gc = (Get-ADDomainController -Discover -Service GlobalCatalog).HostName | Select-Object -First 1
Write-Host "---- Searching Global Catalog ($gc) for $($servers.Count) server(s) ----" -ForegroundColor Cyan

$report = @()
$dcCache = @{}   # domain -> DC list, so each domain is only enumerated once
$n = 0

foreach ($computername in $servers) {
    $n++
    $found = @(Get-ADComputer -Filter "Name -eq '$computername'" -Server "${gc}:3268")

    if ($found.Count -eq 0) {
        Write-Host ""
        Write-Host "---- Summary for $computername ----" -ForegroundColor Cyan
        Write-Host "Computer '$computername' was not found in any domain in the forest." -ForegroundColor Red
        $report += [pscustomobject]@{ Server = $computername; Domain = $null; Enabled = $null; OS = $null
            LastLogon = $null; LastLogonTimestamp = $null; PwdLastSet = $null; LastCheckin = $null }
        continue
    }

    foreach ($obj in $found) {
        $domain = ($obj.DistinguishedName -split ',' | Where-Object { $_ -like 'DC=*' } |
                   ForEach-Object { $_ -replace '^DC=' }) -join '.'

        if (-not $dcCache.ContainsKey($domain)) {
            $dcCache[$domain] = Get-ADDomainController -Filter * -Server $domain | Sort-Object HostName
        }
        $dcs     = $dcCache[$domain]
        $results = @()
        $i       = 0

        foreach ($d in $dcs) {
            $i++
            Write-Progress -Activity "[$n/$($servers.Count)] $computername ($domain)" `
                           -Status "DC $i of $($dcs.Count): $($d.HostName)" `
                           -PercentComplete (100 * $i / $dcs.Count)
            try {
                $c = Get-ADComputer -Identity $obj.DistinguishedName -Server $d.HostName `
                     -Properties lastLogon, lastLogonTimestamp, pwdLastSet, Enabled, OperatingSystem -ErrorAction Stop
                $results += [pscustomobject]@{
                    DC = $d.HostName
                    LastLogon = Convert-FT $c.lastLogon
                    LastLogonTimestamp = Convert-FT $c.lastLogonTimestamp
                    PwdLastSet = Convert-FT $c.pwdLastSet
                    Enabled = $c.Enabled; OS = $c.OperatingSystem; Error = $null
                }
            }
            catch {
                $results += [pscustomobject]@{ DC = $d.HostName; LastLogon = $null; LastLogonTimestamp = $null
                    PwdLastSet = $null; Enabled = $null; OS = $null; Error = $_.Exception.Message }
            }
        }
        Write-Progress -Activity "$computername" -Completed

        # ---- Summary (only section shown) ----
        Write-Host ""
        Write-Host "---- Summary for $computername ($domain) ----" -ForegroundColor Cyan
        $info = $results | Where-Object { -not $_.Error } | Select-Object -First 1
        if ($info) {
            Write-Host ("{0,-20}: {1}" -f 'Enabled', $info.Enabled)
            Write-Host ("{0,-20}: {1}" -f 'Operating system', $info.OS)
            Write-Host ""
        }

        $ll  = Show-Line 'Last logon'         'LastLogon'
        $llt = Show-Line 'LastLogonTimestamp' 'LastLogonTimestamp'
        $pwd = Show-Line 'PwdLastSet'         'PwdLastSet'

        $report += [pscustomobject]@{
            Server = $computername; Domain = $domain
            Enabled = $info.Enabled; OS = $info.OS
            LastLogon          = if ($ll)  { Show-Dt $ll.LastLogon } else { 'Never' }
            LastLogonTimestamp = if ($llt) { Show-Dt $llt.LastLogonTimestamp } else { 'Never' }
            PwdLastSet         = if ($pwd) { Show-Dt $pwd.PwdLastSet } else { 'Never' }
            LastCheckin        = if ($ll)  { "$([int][math]::Floor(((Get-Date) - $ll.LastLogon).TotalDays)) Days" } else { 'Never' }
        }
    }
}

$report | Export-Csv -Path $ResultsCSV -NoTypeInformation -Encoding UTF8

Microsoft.PowerShell.Utility\Write-Host "`n# Results saved to: $ScriptFolder" -ForegroundColor Gray
```

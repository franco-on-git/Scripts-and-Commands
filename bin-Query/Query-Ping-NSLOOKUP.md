
# Query: Ping and NSLOOKUP Server List
> [!NOTE]
> - Pings servers with 2 ICMP packets and runs NSLOOKUP, then live-posts results on screen.
> - Finishies with a summary of all results at the bottom of the query.
> - <ins>NO ADMIN</ins> terminal needed.

<br>

```powershell
clear-host

$servers = Get-Content "C:\LOCAL\pingnslookup.txt"
$results = foreach ($server in $servers) {

    Write-Host "=== Checking $server ===" -ForegroundColor Cyan

    # Ping
    $ping = Test-Connection -ComputerName $server -Count 2 -Quiet
    if ($ping) {
        Write-Host "Ping: Success" -ForegroundColor Green
    } else {
        Write-Host "Ping: Failed" -ForegroundColor Red
    }

    # DNS
    try {
        $dns = Resolve-DnsName -Name $server -ErrorAction Stop |
               Where-Object { $_.Type -eq "A" }

        if ($dns) {
            Write-Host "A Record: Found ($($dns.IPAddress))" -ForegroundColor Green
            $hasA = $true
            $ip   = $dns.IPAddress
        }
        else {
            Write-Host "A Record: Not Found" -ForegroundColor Yellow
            $hasA = $false
            $ip   = $null
        }
    }
    catch {
        Write-Host "A Record: Lookup Failed" -ForegroundColor Red
        $hasA = $false
        $ip   = $null
    }

    Write-Host ""  # spacing

    [PSCustomObject]@{
        Server     = $server
        PingOK     = $ping
        ARecord    = $hasA
        IPAddress  = $ip
    }
}

$results | Format-Table -AutoSize
```
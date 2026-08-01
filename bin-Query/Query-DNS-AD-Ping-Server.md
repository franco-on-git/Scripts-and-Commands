# Query DNS, AD, and Ping for Server Status

## Informational
- Query DNS for A (IPv4) Record
- Query Active Directory for server object
- Ping FQDN from DNS query
- Ping IP from DNS query

## Script Block
```powershell
clear-host

$servername = Read-Host "Server Name"

# NSLOOKUP on server
Write-Host "`nQuerying DNS.." -ForegroundColor yellow
Start-Sleep 2
$result = Resolve-DnsName -Name $servername -ErrorAction SilentlyContinue | Where-Object {$_.type -eq "A"}

if ($result) {
    # Create global VARS from DNS query
    $fqdn = $result.Name
    $ipAddress = $result.IPAddress
    $recordtype = $result.type

    # Output DNS record information
    Write-Host "FQDN: $fqdn"
    write-host "IP:   $ipAddress"
    Write-Host "Type: $recordtype"

    # Check if RSAT AD tools are installed
    if (Get-Module -ListAvailable -Name ActiveDirectory) {
        # Query AD for object
        if ($servername) {
            Write-Host "`nQuerying for AD Record.." -ForegroundColor Yellow
            $adComputer = Get-ADComputer -Filter "Name -eq '$servername'" -Properties *
            Write-Host "OU: $($adComputer.DistinguishedName)"
            Write-Host "GUID: $($adComputer.ObjectGUID)"
            if ($adComputer.SID) {Write-Host "SID: $($adComputer.SID)"}
        }
        else {Write-Host "$servername does not exist in Active Directory." -ForegroundColor Red}

    }
    else {Write-Host "RSAT AD Tools are NOT installed, skipping AD Check" -ForegroundColor Red}

    # Ping FQDN Record
    Write-Host "`nPinging $fqdn.." -ForegroundColor Yellow
    if (Test-Connection -ComputerName $fqdn -Count 2 -Quiet) {Write-Host "Host is up and Running" -ForegroundColor Green}
    else {Write-Host "Ping Failed" -ForegroundColor Red}

    # Ping IP Address
    Write-Host "`nPinging $ipAddress.." -ForegroundColor Yellow
    if (Test-Connection -ComputerName $ipAddress -Count 2 -Quiet) {Write-Host "Host is up and Running" -ForegroundColor Green}
    else {Write-Host "Ping Failed" -ForegroundColor Red}
}
Elseif (!($result)) {Write-Host "$($servername): No DNS Record found" -ForegroundColor Red}
```

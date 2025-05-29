# Disable IPv6
Get-NetAdapterBinding | Where-Object {$_.componentID -eq 'ms_tcpip6'} | Disable-NetAdapterBinding -ComponentID 'ms_tcpip6' -confirm:$false
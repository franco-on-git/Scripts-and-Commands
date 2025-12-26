# Disable IPv6

```powershell
Get-NetAdapterBinding | Where-Object {$_.componentID -eq 'ms_tcpip6'} | Disable-NetAdapterBinding -ComponentID 'ms_tcpip6' -confirm:$false
```

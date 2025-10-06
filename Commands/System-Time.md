> [!WARNING]
> **Always Run Terminal as <ins>Administrator</ins>!**

# Service Status
Verify the `w32time` service is up and running
```
get-service -name w32time | select Status,Name,DisplayName,StartType
```

# Stop time service 
```
net stop w32time 
```

# Start time service 
``` 
net start w32time 
```

# Resync the time 
```
w32tm /resync 
```

# Verify your sync status: 
```
w32tm /query /status 
```

# List Peers
```
w32tm /query /peers 
```

# List out NTP Sources: 
```
w32tm /query /source 
```

# Manual Sync and Source Update:
### Copy Command:
```
w32tm /config /manualpeerlist:"ntp_server_1,ntp_server_2" /syncfromflags:manual /reliable:yes /update
```
### Switch Breakdown:
`w32tm /config`
- This tells the Windows Time Service (W32Time) to change its configuration settings.

`/manualpeerlist:"ntp_server"`
- Defines the NTP server(s) the system will sync time from.
- You can put multiple servers separated by spaces or commas, e.g. `"time.windows.com, pool.ntp.org"`
- You can also append flags (like `,0x8`) to each server for behavior control (like forcing client-only mode).

`/syncfromflags:manual`
- Tells Windows to only use the servers in `/manualpeerlist`.
- Without this, Windows could still try to use domain hierarchy or other sources.
- Flags you can use here:
    - `DOMHIER`: Use domain hierarchy
    - `MANUAL`: Use manual peer list
    - `ALL`: Use all available
    - `NO`: Use none

`/reliable`:yes
- Marks this machine as a reliable time source for the network.
- Typically set on a domain controller (usually the PDC emulator) so other machines can trust it.
- If you set this on a regular workstation or server not intended to be a primary source, it can cause issues.

`/update`
- Forces the Windows Time service to read the updated settings immediately instead of waiting until the next refresh.
- Basically applies the changes right away.



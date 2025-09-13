> [!WARNING]
> **Always Run Terminal as <ins>Administrator</ins>!**

# Service Status
Verify the `w32time` service is up and running
```
get-service -name w32time
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

# To update, use the command below (2008 and 2012 server compatible): 
```
w32tm /config /manualpeerlist:"ntp_server" /syncfromflags:manual /reliable:yes /update
```

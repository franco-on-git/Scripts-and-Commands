# Service
Verify service is up and running
```
get-service -name w32time
```

# Stop time service 
> [!IMPORTANT]
> **Run CMD as <ins>Administrator</ins>!**
```
net stop w32time 
```

# Start time service 
> [!IMPORTANT]
> **Run CMD as <ins>Administrator</ins>!**
``` 
net start w32time 
```

# Resync the time 
> [!IMPORTANT]
> **Run CMD as <ins>Administrator</ins>!**
```
w32tm /resync 
```

# Verify your sync status: 
> [!IMPORTANT]
> **Run CMD as <ins>Administrator</ins>!**
```
w32tm /query /status 
```

# List Peers
> [!IMPORTANT]
> **Run CMD as <ins>Administrator</ins>!**
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

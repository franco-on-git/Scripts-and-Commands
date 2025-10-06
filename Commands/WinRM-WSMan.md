# What is WS-Man?
**Web Services for Management**
- An open standard protocol (SOAP-based) for remote management of systems.
- WS-Man replaced legacy DCOM for remote management
- Provides a common way to access and exchange management information across servers, devices, and applications.
- Microsoft implements it as **WinRM** (Windows Remote Management).
      - dfs
      - To check the status of the service, run the following:
      ```
      Get-Service -name WinRM
      ```
- It underpins **CIM cmdlets** in PowerShell (`Get-CimInstance`, `Get-CimSession`, etc.)
- **PowerShell Remoting** commands like `Enter-PSSession` and `Invoke-Command` rely on WS-Man
- This makes it firewall-friendly and cross-platform.
- Advantages over DCOM:
    - Works across firewalls/NAT (HTTP/s)
    - Secure, so it supports Kerberos, NTLM, CredSSP, and Certifiate-based authentication.
    - Cross-platform (Linux/MacOS) 
- Default Ports:
    - HTTP: 5985
    - HTTPS: 5986

Reference Source: [Querying Management Information by using CIM and WMI](https://infosec.co.il/querying-information-by-cim-and-wmi/)

![](https://github.com/franco-on-git/Images/blob/main/Scripts-and-Commands/WSMan.png)

<br>

# WinRM QuickConfig


- This is a command-line utility used to quickly configure the WinRM service.
- It performs the basic steps necessary to enable WinRM, including:
    - Starting the WinRM service and setting its startup type to automatic.
    - Creating a listener to accept requests on any IP address.
    - Enabling a firewall exception for WS-Management communications.
- It focuses on the core WinRM service configuration.

### Copy Code:
```
winrm quickconfig
```


<br>

# Enable-PSRemoting

- This is a PowerShell cmdlet designed specifically for enabling PowerShell Remoting.
- It performs all the actions of winrm quickconfig and then adds further PowerShell-specific configurations, including:
    - Creating the necessary session endpoint configurations for PowerShell remoting.
    - Enabling all session configurations.
    - Modifying the security descriptor of session configurations to allow remote access.
    - Restarting the WinRM service to apply all changes.
- It provides a more comprehensive setup for PowerShell remoting, ensuring that all necessary PowerShell-related components are correctly configured.

### Copy Code:
```
Enable-PSRemoting
```


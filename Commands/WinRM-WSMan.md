# WinRM and WS-Man Configuration Commands

### What is WS-Man?
**Web Services for Management**
- An open standard protocol (SOAP-based) for remote management of systems.
- WS-Man replaced legacy DCOM for remote management
- Provides a common way to access and exchange management information across servers, devices, and applications.
- Microsoft implements it as **WinRM** (Windows Remote Management).
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

![Sample](https://github.com/franco-on-git/Images/blob/main/Scripts-and-Commands/WSMan.png)

<br>
<br>

# WinRM QuickConfig

### Copy Code:
```
winrm quickconfig
```

- This is a command-line utility used to quickly configure the WinRM service.
- It performs the basic steps necessary to enable WinRM, including:
      - Starting the WinRM service and setting its startup type to automatic.
      - Creating a listener to accept requests on any IP address.
      - Enabling a firewall exception for WS-Management communications.
- It focuses on the core WinRM service configuration.

<br>
<br>

# Enable-PSRemoting

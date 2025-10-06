# WinRM and WS-Man Configuration Commands

### What is WS-Man
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

Reference Source: [Source](https://infosec.co.il/querying-information-by-cim-and-wmi/)


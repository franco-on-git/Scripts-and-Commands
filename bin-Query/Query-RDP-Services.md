# Query RDP Services Status

> [!NOTE]
> **Remote Procedure Call (RPC):** Enables communication between software components on different computers or processes, allowing one to execute code remotely as if it were local.
> **Remote Desktop Configuration:** Manages settings and policies for Remote Desktop Services, including session limits, licensing, and user access.
> **Remote Desktop Services:** Provides technologies that allow users to access a Windows desktop or applications remotely over a network.
> **Remote Desktop Services UserMode Port Redirector:** Handles redirection of local ports (like printers or drives) from the client to the remote session, enabling seamless device access.

## Local Host Only:
```powershell
Get-Service TermService, UmRdpService, SessionEnv, RpcSs | select status,name,displayname,starttype
```

## Remote Host
```powershell
$RemoteHost = read-host "Enter Remote Host Name"
invoke-command -computername $RemoteHost {Get-Service TermService, UmRdpService, SessionEnv, RpcSs}
```

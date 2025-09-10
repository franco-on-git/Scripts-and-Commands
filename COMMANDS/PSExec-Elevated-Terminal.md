# PSExec Elevated Terminal

```diff
- WARNING: Running commands as SYSTEM can be risky! You’re essentially bypassing user-level restrictions
```

## Informational
- The command  launches a interactive shell under the Local **SYSTEM** account. 
- This is a powerful way to run commands with super-elevated privileges on the local machine.

| Switch        | Description
| ------------- | ------------- |
| **-i**  |  (Interactive) Used for debugging, elevated permissions, or access to protected resources |
| **-s** |  (System-level Access) runs local system account, not current user; gives access beyond Admin privileges (non-user level restrictions) |



## Installation
1. Download PSExec from [Sysinternals](https://learn.microsoft.com/en-us/sysinternals/downloads/psexec).
2. Copy executable to any PATH environment variable directory:
```
C:\Windows\System32\psexec.exe
```
3. Start terminal as **ADMIN** and run command to start a shell as SYSTEM: 
```
psxec.exe -i -s cmd.exe
```
5. In shell, run command to verify its using SYSTEM:
```
whoami
```
It should return:
```
NT AUTHORITY\SYSTEM
```


## Why Use This?
- System-Level Access: Running as SYSTEM gives you access beyond even Administrator privileges.
- Interactive Session: Useful for debugging, testing elevated permissions, or accessing protected resources.
- Local Execution: Although PsExec is often used for remote execution, this command runs locally.






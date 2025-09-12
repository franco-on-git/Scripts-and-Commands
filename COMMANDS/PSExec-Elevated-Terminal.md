# PSExec Elevated Terminal

> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> Key information users need to know to achieve their goal.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Advises about risks or negative outcomes of certain actions.
```diff
- WARNING: Running commands as SYSTEM can be risky! You’re essentially bypassing user-level restrictions
```

## Informational
- Command starts a new interactive Command Prompt running under the Windows **NT AUTHORITY\SYSTEM** account.
- This is the highest local system privilege and the most powerful way to run commands with super-elevated privileges on the local machine.

## Why Use This?
- System-Level Access: Running as SYSTEM gives you access beyond even Administrator privileges.
- Interactive Session: Useful for debugging, testing elevated permissions, or accessing protected resources.
- Local Execution: Although PsExec is often used for remote execution, this command runs locally.

## Switches
| Switch        | Description
| ------------- | ------------- |
| **-i**  |  **Interactive:** Used for debugging, elevated permissions, or access to protected resources |
| **-s** |  **System-Level Access:** runs as local system account, not current user; gives access beyond Admin privileges |



## Procedure
1. Download PSExec from [Sysinternals](https://learn.microsoft.com/en-us/sysinternals/downloads/psexec).
2. Copy executable to any PATH environment variable directory:
```
C:\Windows\System32\psexec.exe
```
3. Start terminal as <ins>ADMIN</ins> and run command to start a shell as SYSTEM: 
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








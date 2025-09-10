# PSExec Elevated Terminal

```diff
- Running commands as  can be risky! You’re essentially bypassing user-level restrictions
```


- The command  launches a Command Prompt interactively under the Local System account. 
- This is a powerful way to run commands with elevated privileges on the local machine.

| Switch        | Description
| ------------- | ------------- |
| -i  |  (Interactive) Used for debugging, elevated permissions, or access to protected resources |
| -s  |  (System-level Access) runs local system account, not current user; gives access beyond Admin privileges (non-user level restrictions) |



## Installation
1. Download PSExec from [Sysinternals Website](https://learn.microsoft.com/en-us/sysinternals/downloads/psexec).
2. Copy executable to any environment variable directory 
    **C:\Windows\System32\psexec.exe**
3. Start \_ADMIN\_ Terminal
4. Ran command to start system-level CMD shell: `psxec.exe -i -s cmd.exe`


## Why Use This?
- System-Level Access: Running as  gives you access beyond even Administrator privileges.
- Interactive Session: Useful for debugging, testing elevated permissions, or accessing protected resources.
- Local Execution: Although PsExec is often used for remote execution, this command runs locally.






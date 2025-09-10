# PSExec Elevated Terminal

== Running commands as  can be risky! You’re essentially bypassing user-level restrictions ==

- The command  launches a Command Prompt interactively under the Local System account. 
- This is a powerful way to run commands with elevated privileges on the local machine.

-i (Interactive) Used for debugging, elevated permissions, or access to protected resources
-s (System-level Access) runs local system account, not current user; gives access beyond Admin privileges (non-user level restrictions)

## Installation
1. Download PSExe from [Sysinternal](https://learn.microsoft.com/en-us/sysinternals/downloads/psexec) site
2. Copy executable to any environment variable directory 
    **C:\Windows\System32\psexec.exe**
3. Start \_ADMIN\_ Terminal
4. Ran command to start system-level CMD shell
`psxec.exe -i -s cmd.exe`



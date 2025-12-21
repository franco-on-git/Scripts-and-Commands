# Kill Process via Terminal
### Procedure:
1. Start <ins>Admin</ins> terminal.
2. Find **Process ID** for process you want to kill:
   ```shell
   sc queryex [servicename]
   ```
3. Kill process by PID:
   ```shell
   taskkill /f /pid [PID]
   ```
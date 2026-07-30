# System Monitor (SysMon)


## Informational
- SysMon is  background service and device driver that captures and log deep system-level events on Windows.
- Records security events, process creations, network connections, registry modifications, file creation time changes, and DNS queries.
- Remains resident across system reboots


## Procedure

1. Copy `SysMon` folder to local server

2. Run `SysMon` with <ins>Administrator</ins> terminal
    ```powershell
    Sysmon64.exe -accepteula -i sysmonconfig-export.xml
    ```

3. Analyze the `SysMon` log in **Event Viewer**, export log if needed.

4. Uninstall `SysMon` from system:
    > [!CAUTION]Uninstalling SysMon will remove the Event Viewer log capture.
   ```Powershell
   Sysmon64.exe -u
   ```

# PERFMON | Collect Everything

## Security Context
> [!WARNING] Administrator Terminal Required!


## Informational
- 5 Second Interval sampling
- 1GB max file size


## Code Block
1. Create Data Collector Set
    ```
    Logman.exe create counter _LOGMAN_ALL_5SEC -f bincirc -v mmddhhmm -max 1000 -c "\LogicalDisk(*)\*" "\Memory\*" "\Cache\*" "\Network Interface(*)\*" "\Paging File(*)\*" "\PhysicalDisk(*)\*" "\Processor(*)\*" "\Processor Information(*)\*" "\Process(*)\*" "\Redirector\*" "\Server\*" "\System\*" "\Server Work Queues(*)\*" "\Terminal Services\*" -si 00:00:05 
    ```
2. Start Data Collector: 
    ```
    logman start _LOGMAN_ALL_5SEC
    ```
3. Stop Data Collector:
    ```
    logman stop  _LOGMAN_ALL_5SEC
    ```

<br>

# PERFMON | Collect Process/CPU Only
## Security Context
> [!WARNING] Administrator Terminal Required!


## Informational
- 5 Second Interval sampling
- 1GB max file size


## Code Block
1. Create Data Collector Set
    ```
    ogman.exe create counter _CPU_PROCESS_ONLY_5SEC -f bincirc -v mmddhhmm -max 1000 -c "\Processor(*)\*" "\Process(*)\*" -si 00:00:05 
    ```

2. Start Data Collector:
    ```
    logman start _CPU_PROCESS_ONLY_5SEC
    ```

3. Stop Data Collector:
    ```
    ogman stop  _CPU_PROCESS_ONLY_5SEC
    ```

<br>

# PAL2 | PerfMon Capture Analysis Tool
[PAL2 Tool Link](https://github.com/clinthuffman/PAL) 

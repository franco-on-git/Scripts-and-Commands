## Collect Everything
> [!WARNING]
> **Always Run Terminal as <ins>Administrator</ins>!**

- 5 Second Interval sampling
- 1GB max file size

```
Logman.exe create counter _LOGMAN_ALL_5SEC -f bincirc -v mmddhhmm -max 1000 -c "\LogicalDisk(*)\*" "\Memory\*" "\Cache\*" "\Network Interface(*)\*" "\Paging File(*)\*" "\PhysicalDisk(*)\*" "\Processor(*)\*" "\Processor Information(*)\*" "\Process(*)\*" "\Redirector\*" "\Server\*" "\System\*" "\Server Work Queues(*)\*" "\Terminal Services\*" -si 00:00:05 
```
Start Data Collector: 
```
logman start _LOGMAN_ALL_5SEC
```
Stop Data Collector:
```
logman stop  _LOGMAN_ALL_5SEC
```




## Collect Process/CPU Only
> [!WARNING]
> **Always Run Terminal as <ins>Administrator</ins>!**

- 5 Second Interval sampling
- 1GB max file size
```
Logman.exe create counter _CPU_PROCESS_ONLY_5SEC -f bincirc -v mmddhhmm -max 1000 -c "\Processor(*)\*" "\Process(*)\*" -si 00:00:05 
```

Start Data Collector:
```
logman start _CPU_PROCESS_ONLY_5SEC
```

Stop Data Collector:
```
logman stop  _CPU_PROCESS_ONLY_5SEC
```


# PAL2 PerfMon Capture Analysis Tool
[PAL2 Tool Link](https://github.com/clinthuffman/PAL) 

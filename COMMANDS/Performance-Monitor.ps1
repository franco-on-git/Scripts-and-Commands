# ----------------------------------------------------------------------------------
# COLLECT EVERYTHING COLLECTOR SET
# 5 Second Interval sampling
# 1GB max file size
# !!! Run as Administrator in CMD !!!
Logman.exe create counter _LogMan_5SecInterval -f bincirc -v mmddhhmm -max 1000 -c "\LogicalDisk(*)\*" "\Memory\*" "\Cache\*" "\Network Interface(*)\*" "\Paging File(*)\*" "\PhysicalDisk(*)\*" "\Processor(*)\*" "\Processor Information(*)\*" "\Process(*)\*" "\Redirector\*" "\Server\*" "\System\*" "\Server Work Queues(*)\*" "\Terminal Services\*" -si 00:00:05 

# Start\Stop Data Collector: 
logman start _LOG_ALL_5SEC
logman stop  _LOG_ALL_5SEC


# COLLECT PROCESS/CPU ONLY ----------------------------------------------------------------------------------
# 5 Second Interval sampling
# 1GB max file size
# !!! Run as Administrator in CMD !!!
Logman.exe create counter _CPU_PROCESS_ONLY_5SEC -f bincirc -v mmddhhmm -max 1000 -c "\Processor(*)\*" "\Process(*)\*" -si 00:00:05 

# Start\Stop Data Collector: 
logman start _CPU_PROCESS_ONLY_5SEC
logman stop  _CPU_PROCESS_ONLY_5SEC


# ----------------------------------------------------------------------------------
# PAL2 PerfMon Capture Analyzer Tool: 
https://github.com/clinthuffman/PAL 
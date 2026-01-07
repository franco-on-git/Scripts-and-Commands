# Packet Monitor (pktmon)

> [!WARNING]
> - <ins>Administrator</ins> Terminal Required!
> 
## Informational
- built-in network diagnostic tool for Windows (+Server 2019 / +Windows 10 v1809) that captures traffic across the networking stack.
- It allows for detailed packet inspection, drop detection, and conversion to Wireshark-compatible (PCAPNG) formats. 
- Unlike traditional tools that might only see traffic at the network adapter level, Pktmon can intercept packets at multiple points (components) within the stack, such as filter drivers, virtual switches, and protocol drivers

<br>

## Key Features
- **Multi-Layer Capture**: Captures packets at different layers (Ethernet, Wi-Fi, mobile broadband) and locations within the OS kernel.
- **Drop Detection**: Specifically reports dropped packets and the reason for the drop (e.g., MTU mismatch, VLAN filtering), helping to distinguish between network issues and local configuration errors.
- **Filtering**: Supports granular filtering by IP, port, protocol, and TCP flags to reduce noise.
- **Real-Time Monitoring**: Can display packet counters and events in real-time on the console.
- **Wireshark Compatibility**: Natively converts its proprietary ETL logs into PCAPNG format for analysis in Wireshark. 

<br>

## Switches
| Switch | Description |
| --- | --- |
| `pktmon filter list` | Displays currently active filters. |
| `pktmon filter add` | Creates filters to capture <ins>only</ins> specific traffic (ports, IPs, protocols). <br> - `-m, --mac [-address]`: Match source or destination MAC address. See NOTE1 above. <br> - `-v, --vlan`: Match by VLAN Id (VID) in the 802.1Q header. <br> - `-t, --transport[-protocol], --ip-protocol`:  Match by transport (layer 4) protocol. Can be TCP, UDP, ICMP, ICMPv6, or a protocol number. <br> - `-i, --ip[-address]`: Match source or destination IP address. <br> - `-p, --port`: Match source or destination port number. |
| `pktmon filter remove` | Removes all filters.
| `pktmon counters` | Shows real-time counters of packets flowing through components |
| `pktmon comp list ` | Lists all networking components (adapters, drivers) and their **IDs**. |
| `pktmon etl2pcap` | Converts generated `.etl` log file to `.pcapng` for Wireshark compatibility.|
| `pktmon etl2txt` | Converts generated `.etl` log file to human-readable `.txt` file. |
| `pktmon start --capture --pkt-size 0 --file-name C:\temp\pktmon.etl` | Start the capture <br> `--capture`: Enables packet logging (otherwise it only counts) <br> `--pkt-size 0`: Captures the full packet (0 = no truncation) <br> `f C:\temp`: Log file director.
| `pktmon stop` | Stop the capture and release file lock |

> [!NOTE]
> To isolate only the dropped packets (useful for debugging drops), add the `--drop-only` switch to `pktmon etl2pcap`.

<br>

## COMMAND: Live-View Caputre 
> [!CAUTION]
> A capture without any filters will generate large log files (~30 Sec = 500MB)
1. Start terminal
2. Start capture:
    ```powershell
    pktmon start --etw --pkt-size 0 --log-mode real-time
    ```
3. Reproduce network issue, then stop cature::
    ```powershell
    Ctrl + C
    ```
5. File saved to `C:\Windows\System32\pktmon.etl`

<br>

## COMMAND: Capture All Packets
1. Start terminal
2. Remove old filters:
    ```powershell
    pktmon filter remove
    ```
3. Start capture:
    ```powershell
    pktmon start --capture --pkt-size 0 --file-name C:\Temp\pktmon_capture.etl
    ```
4. Reproduce network issue, then stop cature:
    ```powershell
    pktmon stop
    ```
5. Convert file
    ```powershell
    # Wireshark format
    pktmon etl2pcap C:\Temp\pktmon_capture.etl --out C:\Temp\pktmon_capture.pcapng

    # Text format (human-readable)
    pktmon etl2txt C:\Temp\pktmon_capture.etl --out C:\Temp\pktmon_capture.txt
    ```

<br>

## COMMAND: Capture ICMP, DNS, and SSH specific types
1. Start terminal
2. Remove old filters:
    ```powershell
    pktmon filter remove
    ```
3. Add filters:
    ```powershell
    # These are just samples, modify to needed ports or trasnport type
    pktmon filter add --transport ICMP
    pktmon filter add --port 53
    pktmon filter add --port 22
4. Start capture:
    ```powershell
    pktmon start --capture --pkt-size 0 --file-name C:\Temp\pktmon_capture.etl
    ```
5. Reproduce network issue, then stop cature:
    ```powershell
    pktmon stop
    ```
7. Convert file
    ```powershell
    # Wireshark format
    pktmon etl2pcap C:\Temp\pktmon_capture.etl --out C:\Temp\pktmon_capture.pcapng

    # Text format (human-readable)
    pktmon etl2txt C:\Temp\pktmon_capture.etl --out C:\Temp\pktmon_capture.txt
    ```

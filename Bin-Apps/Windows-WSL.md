# Windows Sub-system for Linux (WSL)

[SOURCE: Microsoft Lear - WSL Basic Commands (link)](https://learn.microsoft.com/en-us/windows/wsl/basic-commands)


## Switches
| Command | Description |
| --- | --- |
| `--install` | Installs WSL feature |
| `--update` | Updates the WSL kernel and components to latest version |
| `--List`  | List of Linux distributions installed on your machine |
| `--list -online` | List of the Linux distributions available from store |
| `--options` | Lists available installations for 'wsl --install'|

<br>

## Installation & Update

1. Install WSL (No distro.. yet):
    ```powershell
    wsl.exe --install --no-distribution
    ```
2. List distro installation options:
    ```powershell
    wsl.exe --list --options
    ```
3. Install Specific Distribution (Defualt is **Ubuntu**):
    ```powershell
    wsl.exe --install --distribution "DistroName" 
    ```
4. Update WSL
    ```powershell
    wsl.exe --update
    ```


<br> 

## Running WSL

Check current status
```powershell
wsl.exe --status
```

Start WSL (Linux user's home directory)
```powershell
wsl ~
```

Stop WSL
```powershell
wsl.exe --shutdown
```

<br>

## Uninstal/Unregister   WSL

> [!CAUTION]
> - Once unregistered, all data, settings, and software associated with that distribution will be permanently lost. 
> - Reinstalling from the store will install a clean copy of the distribution.

```powershell
wsl --unregister <DistributionName>
```

<br>

## Working with WSL

Get IP Address
```powershell
wsl.exe hostname -I
```

# Windows Sub-system for Linux (WSL)

## Switches
| Command | Description |
| --- | --- |
| `-i` or `--install` | Installs WSL feature, <ins>no distro!</ins> |
| `-l` or `--List`  | Lists distributions available from Online. |
| `-o` or `--options` | Lists available installations for 'wsl --install'|

<br>

## Installation

1. Install WSL (No distro.. yet):
    ```powershell
    wsl.exe --install
    ```
2. List distro installation options:
    ```powershell
    wsl -l -o
    ```
3. Install Specific Distribution (Defualt is **Ubuntu**):
    ```powershell
    wsl --install --distribution "DistroName" 
    ```
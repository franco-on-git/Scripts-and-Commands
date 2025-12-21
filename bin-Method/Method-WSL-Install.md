
| Command | Description |
| --- | --- |
| `-l` or `--List`  | Lists distributions available from Online |
| `-o` or `--options` | Lists available installations for 'wsl --install'|

<br>

| Name | Friendly Name |
| --- | --- |
| * Ubuntu  | Ubuntu |
| Debian | Debian GNU/Linux |
| Kali-Linux | Kali Linux Rolling |
| OracleLinux_9_1 | Oracle Linux 9.1 |
| openSUSE-Leap-15.6 | openSUSE Leap 15.6|
|openSUSE-Tumbleweed | openSUSE Tumbleweed |

<br>

# List distro installation options
```powershell
wsl -l -o
```
# Install Specific Distribution
```powershell
wsl --install --distribution DistroName 
```
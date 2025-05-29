
<#

-l or --List 
Lists distributions available from Online

-o or --options
 List available installations for 'wsl --install'

NAME                            FRIENDLY NAME
* Ubuntu                          Ubuntu
  Debian                          Debian GNU/Linux
  kali-linux                      Kali Linux Rolling
  Ubuntu-18.04                    Ubuntu 18.04 LTS
  Ubuntu-20.04                    Ubuntu 20.04 LTS
  Ubuntu-22.04                    Ubuntu 22.04 LTS
  Ubuntu-24.04                    Ubuntu 24.04 LTS
  OracleLinux_7_9                 Oracle Linux 7.9
  OracleLinux_8_7                 Oracle Linux 8.7
  OracleLinux_9_1                 Oracle Linux 9.1
  openSUSE-Leap-15.6              openSUSE Leap 15.6
  SUSE-Linux-Enterprise-15-SP5    SUSE Linux Enterprise 15 SP5
  SUSE-Linux-Enterprise-15-SP6    SUSE Linux Enterprise 15 SP6
  openSUSE-Tumbleweed             openSUSE Tumbleweed
#>

# List distro installation options
wsl -l -o

# Install distro
wsl --install --distribution name 
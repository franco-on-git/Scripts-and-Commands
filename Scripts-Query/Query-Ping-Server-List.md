> [!NOTE]
> - Pings servers with 2 ICMP packets then posts results on screen
> - Exports results to local temp directory: **"C:\Temp\ServerStatusReport.txt"**
> - <ins>NO ADMIN</ins> terminal needed


```Powershell
#AM OR PM TIME INDICATOR
$AmOrPm = Get-Date -UFormat %p
If ($AmOrPm -eq 'AM') {$AmPM = "am"}
ElseIf ($AmOrPm -eq 'PM') {$AmPM = "pm"}


#SCRIPT HOME DIRECTORY
$ScriptName = "ServerPings - $(Get-Date -f MM_dd_yyyy_hhmm)$AmPM"
$ScriptFolder = "$env:userprofile\desktop\WINDOWS SUPPORT\$ScriptName"
If (!($scripfolder)) {New-Item -Path $ScriptFolder -ItemType directory | Out-Null}


#FUNCTION FOR EXPLORER POP-UP BOX TO SELECT FILE
Function Get-FileName($initialDirectory)
{   
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
 Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "All files (*.*)| *.*"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
}


# SCRIPT BANNER------------------------------------------------------------------------
# ASCII Test site = http://patorjk.com/software/taag/#p=testall&f=Graffiti&t=GetHotFix
# ASCII Text Font = Slant
# -------------------------------------------------------------------------------------
write-host " "
Start-Sleep -m 250 
Write-host "|>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>|"
Write-host "|   _____                           ____  _                  |" 
Write-host "|  / ___/___  ______   _____  _____/ __ \(_)___  ____ ______ |"
Write-host "|  \__ \/ _ \/ ___/ | / / _ \/ ___/ /_/ / / __ \/ __ `/ ___/  |"
Write-host "| ___/ /  __/ /   | |/ /  __/ /  / ____/ / / / / /_/ (__  )  |"
Write-host "|/____/\___/_/    |___/\___/_/  /_/   /_/_/ /_/\__, /____/   |"
Write-Host "|                                             /____/         |"
Write-host "|<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<|"
Start-Sleep -m 250
Write-Host " "


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


# POPUP TO SELECT SERVER LIST FROM FILE, GET IT'S CONTENTS AND PUT IT INTO A VARIABLE
Write-Host "Select Server List ("".txt"" or "".csv"")..." -ForegroundColor White
Start-Sleep 1
Write-Host

$ServerList = Get-FileName
$servers = Get-Content $ServerList


$collection = $()
foreach ($server in $servers) {}
{
    $status = @{ "ServerName" = $server}
    if (Test-Connection $server -Count 2 -ea 0 -Quiet)
    { 
        $status["Results"] = "Up"
    } 
    else 
    { 
        $status["Results"] = "Down" 
    }
    New-Object -TypeName PSObject -Property $status -OutVariable serverStatus
    $collection += $serverStatus

    }

$collection | Export-Csv "$ScriptFolder\$ScriptName.csv"

(Get-Content "$ScriptFolder\$ScriptName.csv" | Select-Object -Skip 1) | Set-Content "$ScriptFolder\$ScriptName.csv"

Invoke-Item "$ScriptFolder\$ScriptName.csv"
```

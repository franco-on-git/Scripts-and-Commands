Query: Ping Server List
> [!NOTE]
> - Pings servers with 2 ICMP packets then posts results on screen
> - Exports results to local temp directory: **"C:\Temp\ServerStatusReport.txt"**
> - <ins>NO ADMIN</ins> terminal needed



```powershell
clear-Host

Write-Host "Server List File:" -ForegroundColor Cyan
write-Host ""

# Function for pop-up window to select a file
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

# Variable to get contents from Get-File function
$ServerList = Get-FileName

# Output file selection
$ServerList

Write-Host ""

# Define the path to the text file containing your server names
$ServerListFile = Get-Content $ServerList
# Optional: Define an output file path for a log/report
$OutputFile = "C:\Temp\ServerStatusReport.txt"

# Clear previous output file if it exists and write header
Clear-Content -Path $OutputFile
Add-Content -Path $OutputFile -Value "Server Status Report - $(Get-Date)"
Add-Content -Path $OutputFile -Value "---------------------------------------"

# Import the server list from the file, one name per line
$Servers = Get-Content -Path $ServerList

Write-Host "Starting connectivity test..." -ForegroundColor Cyan
Write-Host "" -ForegroundColor Cyan

# Loop through each server in the list
foreach ($Server in $Servers) {
    # Remove leading/trailing white space
    $Server = $Server.Trim()

    # Skip empty lines in the text file
    if ($Server) {
        Write-Host "Testing $Server :" -NoNewline

        # Test the connection; -Count 2 sends a two ICMP packet
        if (Test-Connection -ComputerName $Server -Count 2 -ErrorAction SilentlyContinue) {
            $StatusMessage = "$Server is UP"
            Write-Host " UP" -ForegroundColor Green
        } else {
            $StatusMessage = "$Server is DOWN"
            Write-Host " DOWN" -ForegroundColor Red
        }
        
        # Append the status message to the output report file
        Add-Content -Path $OutputFile -Value $StatusMessage
    }
}

write-host ""
Write-Host "---------------------------------------" -ForegroundColor Cyan
Write-Host "Testing complete. Results saved to $OutputFile" -ForegroundColor Cyan

sleep 2

# Open explorted results TXT file
Invoke-Item $OutputFile
```
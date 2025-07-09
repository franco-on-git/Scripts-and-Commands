# !!! Must run Powershell ISE as ADMINISTRATOR !!!


$spooldirectory = "C:\Windows\System32\spool\PRINTERS"

# stop print spooler
write-host "Stopping Print Spooler Service..." -ForegroundColor Yellow
write-host " "

Stop-Service -Name Spooler -Force
Start-Sleep 5

# remove contents of PRINTERS directory and restart service
$spoolerstatuspost = (Get-Service -Name spooler).Status

If ($spoolerstatuspost -eq "stopped") {Write-Host "Spooler service Successfully stopped!" -ForegroundColor Green
                                       write-host " "

                                       Write-Host "Deleting contents of $($spooldirectory)..." -ForegroundColor Yellow
                                       write-host " "

                                       Get-ChildItem -Path $spooldirectory -Include *.* -File -Recurse | ForEach-Object { $_.Delete()}
                                       Start-Sleep 5
                                       Write-Host "Done!"  -ForegroundColor Green
                                       write-host " "

                                       write-host "Restarting Spooler Service..." -ForegroundColor Yellow
                                       Start-Service Spooler
                                       start-sleep 5

                                       $spoolerstatuspost2 = (Get-Service -Name spooler).Status
                                            If ($spoolerstatuspost2 -eq "running") {write-host " "
                                                                          Write-Host "Done! ...script complete!" -ForegroundColor Green
                                                                          write-host " "     
                                                                          }
                                            else {write-host "Spooler Service failed to start, manual check required" -ForegroundColor Red}  
                                     }


Else {write-host "Print Spooler Failed to Stop, manual intervention required.." -ForegroundColor Red }
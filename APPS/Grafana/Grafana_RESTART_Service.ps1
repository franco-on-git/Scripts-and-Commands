$GrafanaService = Get-WmiObject -Class Win32_Service -Filter "Name='grafana-agent'" 

if (!($GrafanaService)) {write-host "Grafana Agent Missing"} 

else {Stop-Service -Name grafana-agent
      Start-Sleep 5
      Start-Service -Name  grafana-agent
      Start-Sleep 5

      $GrafanaState = ($GrafanaService).State

        If($GrafanaState -ne 'Running') {Write-Host "Service Failed to Start"}
                                        
        Else {Write-Host "Service restart successfull"}

      }



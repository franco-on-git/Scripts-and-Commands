# Query All VMs in a Cluster

1. Connect to vCenter first

2. Copy Script:
   ```Powershell
   Clear-Host

    $inputName = Read-Host "Enter partial Cluster Name"
    $clusters = Get-Cluster -Name "*$inputName*" -ErrorAction SilentlyContinue

    if ($clusters) {
    # Gather all VMs in the matched clusters
    $vms = $clusters | Get-VM | Sort-Object name
    $vmCount = $vms.Count


    # Display the VM Count Summary
    Write-Host "`nTotal VMs Found: $vmCount" -ForegroundColor Yellow

    # Process the "Pharmacy Store" logic
    foreach ($vm in $vms) {
        if ($vm.Name -like "F*") {
            Write-Host "`nThis is a Pharmacy Store ($($vm.Name))" -ForegroundColor Cyan
        }
    }

     # Process the "Bar and Restaurant" logic
    foreach ($vm in $vms) {
        if ($vm.Name -like "W*") {
            Write-Host "`nThis is a Bar&Restaurant Store ($($vm.Name))" -ForegroundColor Cyan
        }
    }

    # Output the detailed table Widnows
        Write-Host "`nWINDOWS VMs" -ForegroundColor Green
        Write-Host "============"
        $vms | ? {$_.GuestID -like 'windows*'} |  Select-Object Name, PowerState, GuestId, NumCpu, MemoryGB, CreateDate | FT -AutoSize

    # Output the detailed table Widnows
        Write-Host "`nLINUX VMs" -ForegroundColor Green
        Write-Host "============"
        $vms | ? {$_.GuestID -like 'RHEL*'} |  Select-Object Name, PowerState, GuestId, NumCpu, MemoryGB, CreateDate | FT -AutoSize
    } else {
    Write-Warning "No clusters found matching '*$inputName*'"
    }

```

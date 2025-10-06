cls

Function PressAnyKeyToContinue {
# This pop-up box pauses script process until clicking Ok
$oReturn = [System.Windows.Forms.Messagebox]::Show("**** WARNING: Server Will Reboot once script is completed! ****")
$oReturn}

# *****************************************************************
# Run GPUpdate command
Write-Host "Running GPUdate..." -ForegroundColor Yellow
gpupdate /force
Write-Host "Done!" -ForegroundColor
Write-Host ""


# *****************************************************************
# CCTV Backstage admin group addition
Write-Host "Adding CCTV Backstage Admin - GG to local Administrator's group..." -ForegroundColor Yellow
Add-LocalGroupMember -Group "Administrators" -Member "safeway01\CCTV Backstage Admin - GG" -ErrorAction SilentlyContinue
Write-Host "Done!" -ForegroundColor Green
Write-Host ""

Write-Host "Verifying Local Admins addition..." -ForegroundColor Yellow
$CCTVSecAdd = Get-LocalGroupMember -Group "Administrators" | Where-Object {$_.name -eq "safeway01\CCTV Backstage Admin - GG"}
If ($CCTVSecAdd) {Write-Host "CCTV Admins group successfully added..." -ForegroundColor Green
                  $CCTVSecAdd
                  }
Else {write-host "Something went wrong, may need to add manually!" -ForegroundColor Red}


# *****************************************************************
# COPY AND RUN CCTV BACKSTAGE SCRIPT
Write-Host "Copying CCTV Build script..." -ForegroundColor Yellow
New-PSDrive -Name "X" -PSProvider FileSystem -Root "\\pnn0114b9\DropStuffHere\CCTV_Build_Stuff\"
Start-Sleep -Seconds 5
Copy-Item -Path "X:\Backstage_CCTV_Build_Script.ps1" -Destination C:\Install
Write-Host ""

Write-Host "Running CCTV Build script..." -ForegroundColor Yellow
Start-Sleep 3
PressAnyKeyToContinue

Set-Location -Path C:\Install
start-sleep -Seconds 1
& .\Backstage_CCTV_Build_Script.ps1

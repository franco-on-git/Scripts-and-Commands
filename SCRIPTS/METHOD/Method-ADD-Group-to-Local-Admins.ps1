

# CCTV Backstage admin group addition
Write-Host "Adding CCTV Backstage Admin - GG to local Administrator's group..." -ForegroundColor Yellow
Add-LocalGroupMember -Group "Administrators" -Member "safeway01\CCTV Backstage Admin - GG" -ErrorAction SilentlyContinue

$CCTVSecAdd = Get-LocalGroupMember -Group "Administrators" | Where-Object {$_.name -eq "safeway01\CCTV Backstage Admin - GG"}
If ($CCTVSecAdd) {Write-Host "CCTV Admins group successfully added..." -ForegroundColor Green
                  $CCTVSecAdd
                  }
Else {write-host "Something went wrong, may need to add manually!" -ForegroundColor Red}
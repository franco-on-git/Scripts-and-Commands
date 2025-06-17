
# ----------------------------------------------------------------------------------
# QUICK QUERY FOR ON-SCREEN COPY
(Get-ADObject -Server domain.com -SearchBase "OU=Name,OU=Name,DC=Domain,DC=Domain,DC=com" -Filter * -Properties *).CN | Sort-Object | out-file C:\Users\Username\Desktop\AD_Results.txt


#-------------------------------------------------------------------------------------------------------------
# QUERY AND EXPORT TO CSV
$OUPath = "OU=Name,OU=Name,DC=Domain,DC=Domain,DC=com" 
$ExportPath = "C:\temp\OU_Export.csv" 

Get-ADObject -Server domain.com -SearchBase $OUPath -Filter * -Properties * | Select-Object CN | Export-Csv $ExportPath -NoTypeInformation -Force

Invoke-Item $ExportPath
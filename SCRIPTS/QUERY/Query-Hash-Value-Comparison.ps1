# Algorithm Selection box
Add-Type -AssemblyName System.Windows.Forms

$choices = @("MD5", "SHA1", "SHA256","SHA512")
$form = New-Object System.Windows.Forms.Form
$form.Text = "Choose an Algorithm"
$form.Size = New-Object System.Drawing.Size(300,150)
$form.StartPosition = "CenterScreen"

$listbox = New-Object System.Windows.Forms.ListBox
$listbox.Size = New-Object System.Drawing.Size(260,60)
$listbox.Location = New-Object System.Drawing.Point(10,10)
$listbox.SelectionMode = "One"
$listbox.Items.AddRange($choices)
$form.Controls.Add($listbox)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Text = "OK"
$okButton.Location = New-Object System.Drawing.Point(100,80)
$okButton.Add_Click({ $form.Close() })
$form.Controls.Add($okButton)

$form.ShowDialog() | Out-Null

$AlgorithmOption = $listbox.SelectedItem
Write-Host "Algorithm selected:" -ForegroundColor yellow
Write-Host "$AlgorithmOption" -ForegroundColor White
write-host ""
Start-Sleep 1

# Verify algorithm option value is not $null
if ($null -eq $AlgorithmOption ) {write-host "No option selected, exiting script..." -ForegroundColor Yellow
                                 Start-Sleep 3
                                 exit}


# Fuction to select file for hash value
Write-Host "Select a file..." -ForegroundColor Yellow
Write-Host ""
Start-Sleep 3

Function Get-File($initialDirectory) 
{    
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |  Out-Null 
 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog 
 $OpenFileDialog.initialDirectory = $initialDirectory 
 $OpenFileDialog.filter = "All files (*.*)| *.*" 
 $OpenFileDialog.ShowDialog() | Out-Null 
 $OpenFileDialog.filename 
} 


# File path selection and verbose output of directory
$filePath = Get-File


Write-Host "File selected:" -ForegroundColor Yellow
Write-Host "$filePath" -ForegroundColor White
Write-Host " "

# Get the file's checksum
$hash = (Get-FileHash -Path $filePath -Algorithm $AlgorithmOption).hash
Write-Host ""

Write-Host "Hash Value:" -ForegroundColor Yellow
Write-Host "$hash"
Write-Host ""

Write-Host "*****************************" -ForegroundColor Yellow
Write-Host ""


$Yourhash = Read-Host "Enter Compariosn Hash"
Write-Host ""

# Hash value comparison and results
if ($hash -eq $Yourhash) {
    Write-Host "Hash Values Match!" -ForegroundColor Green
}

else {Write-Host "Hash Values DO NOT MATCH!" -ForegroundColor Red}


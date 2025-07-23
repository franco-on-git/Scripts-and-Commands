clear-host

# ----------------------------------------------------------------------------------
# Algorithm Selection box
Add-Type -AssemblyName System.Windows.Forms

$choices = @("MD5", "SHA1", "SHA256", "SHA512")

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

Write-Host "Algorithm selected:" -ForegroundColor Yellow
Write-Host "$AlgorithmOption" -ForegroundColor White
Write-Host ""
Start-Sleep 1


# ----------------------------------------------------------------------------------
# Verify algorithm selection value is not $null
if ($null -eq $AlgorithmOption) {
    Write-Host "No option selected, exiting script..." -ForegroundColor Yellow
    Start-Sleep 3
    exit
}


# ----------------------------------------------------------------------------------
# FUNCTION to select target file to check for hash value
Write-Host "Select a file..." -ForegroundColor cyan
Write-Host ""
Start-Sleep 2

Function Get-File($initialDirectory) {
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null 
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog 
    $OpenFileDialog.initialDirectory = $initialDirectory 
    $OpenFileDialog.filter = "All files (*.*)| *.*" 
    $OpenFileDialog.ShowDialog() | Out-Null 
    $OpenFileDialog.filename 
}


# ----------------------------------------------------------------------------------
# Verbose output of target file's directory
$filePath = Get-File

Write-Host "File selected:" -ForegroundColor Yellow
Write-Host "$filePath" -ForegroundColor White
Write-Host ""
Start-Sleep 1


# ----------------------------------------------------------------------------------
# Get target file's checksum
Write-Host "Checking file, could take a bit..." -foregroundcolor cyan
$hash = (Get-FileHash -Path $filePath -Algorithm $AlgorithmOption).hash

Write-Host ""
Write-Host "File hash value:" -ForegroundColor Yellow
Write-Host "$hash"
Write-Host ""
Start-Sleep 1

Write-Host "*****************************" -ForegroundColor Yellow
Write-Host ""


# ----------------------------------------------------------------------------------
# Enter the hash value provided by vendor or website for verification
$Yourhash = Read-Host "Enter Comparison Hash"
Write-Host ""


# ----------------------------------------------------------------------------------
# Hash value comparison and results
if ($hash -eq $Yourhash) {
    Write-Host "Hash Values Match!" -ForegroundColor yellow
    Write-Host ""
    Write-Host "== $hash ==" -ForegroundColor green
    Write-Host "== $Yourhash ==" -ForegroundColor green
} else {
    Write-Host "Hash Values DO NOT MATCH!" -ForegroundColor Red
}
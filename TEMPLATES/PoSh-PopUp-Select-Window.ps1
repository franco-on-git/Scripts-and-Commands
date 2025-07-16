<#
   .NOTES
        Author: Franco-hq
        Created: 07/25

    .SYNOPSIS
        Template that uses a popup box to select a file or folder

    .DESCRIPTION
        -Reference the "Get-File" as as source of the target
#>

# ----------------------------------------------------------------------------------
Function Get-File($initialDirectory) 
{    
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |  Out-Null 
 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog 
 $OpenFileDialog.initialDirectory = $initialDirectory 
 $OpenFileDialog.filter = "All files (*.*)| *.*" 
 $OpenFileDialog.ShowDialog() | Out-Null 
 $OpenFileDialog.filename 
} 

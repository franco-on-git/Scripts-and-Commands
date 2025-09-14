# Displays a message at the terminal
# Paste "PressAnyKeyToContinue" at the end when exiting script 
# Copy Function below to Top of Script

# ----------------------------------------------------------------------------------
Function PressAnyKeyToContinue {
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');}

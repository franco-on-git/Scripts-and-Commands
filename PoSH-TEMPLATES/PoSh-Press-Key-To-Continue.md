> [!NOTE]
> - Displays a message at the terminal to press any key before doing anything else.
> - Paste "PressAnyKeyToContinue" function name when something needs waiting confirmation before continuing.  
> - Copy Function below to Top of scirpt first. 

# Copy Code:
```
Function PressAnyKeyToContinue {
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');}
```

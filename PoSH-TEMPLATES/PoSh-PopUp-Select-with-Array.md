> [!NOTE]
> - Template that uses a popup box to select a file with servers to run a script against.
> - Plug in your script in the "do something" brackets.
> - Make sure to enter "$server" variable when referencing the object you're targeting within the array.

```
Function Get-File($initialDirectory) 
{    
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |  Out-Null 
 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog 
 $OpenFileDialog.initialDirectory = $initialDirectory 
 $OpenFileDialog.filter = "All files (*.*)| *.*" 
 $OpenFileDialog.ShowDialog() | Out-Null 
 $OpenFileDialog.filename 
} 

# Variable pointing to new object
$ServerList = Get-File

# Get contents of new object variable
$servers = Get-Content $ServerList 

# Array with contents from file selected
foreach ($server in $servers) {"Do something"} 
```

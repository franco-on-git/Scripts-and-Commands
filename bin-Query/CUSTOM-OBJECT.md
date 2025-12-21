# Custom Object Template
> [!NOTE]
> - Creates custom object from a combination of diffrent objects.
> - [Source: StackOverflow](https://stackoverflow.com/questions/62110520/how-can-i-get-my-function-to-run-the-custom-object-for-the-computer-names)


## Copy Code:
```
# Define new object variable objects
$os = Get-WmiObject –class Win32_OperatingSystem –comp localhost 

$cs = Get-WmiObject –class Win32_ComputerSystem –comp localhost 

$bios = Get-WmiObject –class Win32_BIOS –comp localhost 

$proc = Get-WmiObject –class Win32_Processor –comp localhost | 

Select-Object –first 1 

 
# Create new object
$objects = @{OSVersion=$os.version 

           Model=$cs.model 

           Manufacturer=$cs.manufacturer 

           BIOSSerial=$bios.serialnumber 

           ComputerName=$os.__SERVER 

           OSArchitecture=$os.osarchitecture 

           ProcArchitecture=$proc.addresswidth} 

$obj = New-Object –TypeName PSObject –Property $objects 

# Output results from new object
Write-Output $obj 
```

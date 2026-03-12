# Query: System Service Status

> [!WARNING]
> - **<ins>Administrator</ins> Terminal required!**

> [!NOTE]
> - Check services status for single or multiple services from a single server
> - ex. <ins>vds|alloy|installer</ins> or <ins>windows,virtual,disk</ins>

```powershell
Clear-Host

$server   = Read-Host "Server Name"
$services = Read-Host "Service Names (comma‑separated, supports regex & partial matches)"

# Convert comma-separated input into a single regex pattern
$pattern = ($services -split ',' | ForEach-Object { $_.Trim() }) -join '|'

Get-Service -ComputerName $server |
    Where-Object {
        $_.Name -match $pattern -or
        $_.DisplayName -match $pattern
    } |
    Select-Object @{
        Name='Hostname'
        Expression={ $server }
    }, StartType, Status, Name, DisplayName |
    Format-Table -AutoSize

```

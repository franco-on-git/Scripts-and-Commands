# Powershell: Display full terminal text

To display full text in terminal, pipe the result to `Format-Table -AutoSize`.

```
get-service winrm | ft -AutoSize
```

![Sample](https://github.com/franco-on-git/Images/blob/main/Scripts-and-Commands/Full_Text.png)

<br>

# Windows Environment Variables
Computername:
```powershell
$env:COMPUTERNAME
```

User Profile:
```powershell
$env:USERPROFILE
```
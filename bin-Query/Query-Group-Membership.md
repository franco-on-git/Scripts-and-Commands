
# USER Memebership (Active Directory)
> [!NOTE]
> - Security groups that a <ins>user</ins> is part of.

```powershell
Get-ADPrincipalGroupMembership userLDAP | sort-object | Select-Object name 
```

<br>

# COMPUTER Membership (Active Directory)
> [!NOTE]
> - Security membership that a <ins>computer</ins> object is part of.

```powershell
Get-ADPrincipalGroupMembership (Get-ADComputer computername).DistinguishedName | select-object samaccountname 
```

<br>

# Network Folder Membership
> [!NOTE]
> - Who is part of local Administrators Group

```powershell
$TargetFolder = "\\folder\directory"
(Get-Acl -Path $TargetFolder).Access | Select-Object identityreference
```

<br>

# Local Administrators Group Membership
> [!NOTE]
> - Who is part of local Administrators Group
```powershell
Get-LocalGroupMember -Group "Administrators"
```
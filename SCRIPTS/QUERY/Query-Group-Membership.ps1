<#
    .NOTES
        Author: Roboute Guilliman
        Created: 09/2024

    .SYNOPSIS
        -Queries security group memebership for AD User or Computer in Active Directory
        -Queries Network folder scurity permissions
        -Queries local computer's security memebership for a specific group

    .DESCRIPTION
        -The Get-ADPrincipalGroupMembership cmdlet gets the Active Directory groups that have a specified user, computer, group, or service account as a member. 
        -This cmdlet requires a global catalog to perform the group search.
#>

# ----------------------------------------------------------------------------------
# ACTIVE-DIRECTORY-USER-memebership
Get-ADPrincipalGroupMembership UserID | sort-object | Select-Object name 

# ACTIVE-DIRECTORY-COMPUTER-Memebership
Get-ADPrincipalGroupMembership (Get-ADComputer computername).DistinguishedName | select-object samaccountname 


# ----------------------------------------------------------------------------------
# Network-FOLDER-Membership
$TargetFolder = "\\folder\directory"
(Get-Acl -Path $TargetFolder).Access | Select-Object identityreference


# ----------------------------------------------------------------------------------
# LOCAL-Group-Membership
Get-LocalGroupMember -Group "Administrators"
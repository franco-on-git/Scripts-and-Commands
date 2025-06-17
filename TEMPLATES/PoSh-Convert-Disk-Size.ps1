
# ONLY WORKS WITH AN OBJECT THAT COINTAINS THE "SIZE" PROPERTY
# COPY THE FUNCTION TO THE TOP OF THE SCRIPT

@{Expression={Convert-BytesToSize $_.Size};Label="Size"}


# ----------------------------------------------------------------------------------
Function Convert-BytesToSize
{
[CmdletBinding()]
Param
(
[parameter(Mandatory=$False,Position=0)][int64]$Size
)

#Decide what is the type of size
Switch ($Size)
{
{$Size -gt 1PB}
{
Write-Verbose “Convert to PB”
$NewSize = “$([math]::Round(($Size / 1PB),2))PB”
Break
}
{$Size -gt 1TB}
{
Write-Verbose “Convert to TB”
$NewSize = “$([math]::Round(($Size / 1TB),2))TB”
Break
}
{$Size -gt 1GB}
{
Write-Verbose “Convert to GB”
$NewSize = “$([math]::Round(($Size / 1GB),2))GB”
Break
}
{$Size -gt 1MB}
{
Write-Verbose “Convert to MB”
$NewSize = “$([math]::Round(($Size / 1MB),2))MB”
Break
}
{$Size -gt 1KB}
{
Write-Verbose “Convert to KB”
$NewSize = “$([math]::Round(($Size / 1KB),2))KB”
Break
}
Default
{
Write-Verbose “Convert to Bytes”
$NewSize = “$([math]::Round($Size,2))Bytes”
Break
}
}
Return $NewSize}


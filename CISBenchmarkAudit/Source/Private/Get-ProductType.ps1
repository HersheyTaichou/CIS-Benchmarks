<#
.SYNOPSIS
Get the product type

.DESCRIPTION
Get and return the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Get-ProductType

2

.NOTES
General notes
#>
function Get-ProductType {
    [CmdletBinding()]
    param ()

    [int]$ProductType = (Get-CimInstance -ClassName Win32_OperatingSystem).ProductType
    return $ProductType
}
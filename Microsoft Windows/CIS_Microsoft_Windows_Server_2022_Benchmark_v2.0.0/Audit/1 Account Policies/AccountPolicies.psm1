# This module is designed to provide functions that test for complaince with CIS Benchmarks Version 2.0.0 for Windows Server 2022

<#
.SYNOPSIS
1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more password(s)' (Automated)

.DESCRIPTION
Long description

.PARAMETER FirstParam
Parameter description

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-Function {
    [CmdletBinding()]
    param (
        [Parameter()][String]$FirstParam
    )
}

Export-ModuleMember -Function Test-Function
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
function Test-PasswordHistory {
    [CmdletBinding()]
    param (
        [Parameter()][String]$FirstParam
    )
    Write-Verbose "This settings is required for Level 1 compliance"
    Write-Information "For compliance, password history should be set to 24 or more passwords remembered."
    $PasswordPolicy = Get-ADDefaultDomainPasswordPolicy
    if ($PasswordPolicy.PasswordHistoryCount -lt "24") {
        $message = "Password history is set to " + $PasswordPolicy.PasswordHistoryCount + " and does not meet the requirement. Increase the policy to 24 or greater."
        Write-Warning $message
    } else {
        $message = "Password history is set to " + $PasswordPolicy.PasswordHistoryCount + " and does meet the requirement."
        Write-Information $message
    }
}

Export-ModuleMember -Function Test-PasswordHistory
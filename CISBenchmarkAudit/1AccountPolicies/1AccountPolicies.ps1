<#
.SYNOPSIS
1.1 Password Policy

.DESCRIPTION
This command will test for the 7 settings defined in section 1.1 of the 
CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level. 

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, 
at the risk of breaking some functionality. This level requires and includes all the
Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments taht can support them.

.EXAMPLE
Test-PasswordPolicy -Level 1 -ServerType DomainController

.NOTES
General notes
#>
function Test-AccountPoliciesPasswordPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    $ServerType = Get-ProductType

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    Test-PasswordPolicyPasswordHistory
    Test-PasswordPolicyMaxPasswordAge
    Test-PasswordPolicyMinPasswordAge
    Test-PasswordPolicyMinPasswordLength
    Test-PasswordPolicyComplexityEnabled
    if ($ServerType -eq 3) {
        Test-PasswordPolicyRelaxMinimumPasswordLengthLimits
    }
    Test-PasswordPolicyReversibleEncryption
}

<#
.SYNOPSIS
1.2 Account Lockout Policy

.DESCRIPTION
This command will test for the 4 settings defined in section 1.2 of the 
CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level. 

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, 
at the risk of breaking some functionality. This level requires and includes all the
Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments taht can support them.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-AccountPoliciesAccountLockoutPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    $ServerType = Get-ProductType

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    Test-AccountLockoutPolicyLockoutDuration
    Test-AccountLockoutPolicyLockoutThreshold
    if ($ServerType -eq 3) {
        Test-AccountLockoutPolicyAdminLockout
    }
    Test-AccountLockoutPolicyResetLockoutCount

}

<#
.SYNOPSIS
1 Account Policies

.DESCRIPTION
This command will test for all the settings defined in section 1 of the 
CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level. 

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, 
at the risk of breaking some functionality. This level requires and includes all the
Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments taht can support them.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-CISBenchmarkAccountPolicies {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    Test-AccountPoliciesPasswordPolicy -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-AccountPoliciesAccountLockoutPolicy -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
}

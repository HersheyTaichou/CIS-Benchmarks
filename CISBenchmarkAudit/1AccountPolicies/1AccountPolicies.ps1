<#
.SYNOPSIS
1.1 Password Policy

.DESCRIPTION
This command will test all the settings defined in section 1.1 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level.

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, at the risk of breaking some functionality. This level requires and includes all the Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments that can support them.

.EXAMPLE
Test-PasswordPolicy -Level 1 -ServerType DomainController

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.1.1     (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'                           Group Policy Settings     True    
1.1.2     (L1) Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'                         Group Policy Settings     True    
1.1.3     (L1) Ensure 'Minimum password age' is set to '1 or more day(s)'                                     Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AccountPoliciesPasswordPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)

    )
    Test-PasswordPolicyPasswordHistory -ProductType $ProductType -GPResult $GPResult
    Test-PasswordPolicyMaxPasswordAge -ProductType $ProductType -GPResult $GPResult
    Test-PasswordPolicyMinPasswordAge -ProductType $ProductType -GPResult $GPResult
    Test-PasswordPolicyMinPasswordLength -ProductType $ProductType -GPResult $GPResult
    Test-PasswordPolicyComplexityEnabled -ProductType $ProductType -GPResult $GPResult
    if ($ProductType -eq 3) {
        Test-PasswordPolicyRelaxMinimumPasswordLengthLimits -gpresult $GPResult
    }
    Test-PasswordPolicyReversibleEncryption -gpresult $GPResult
}

<#
.SYNOPSIS
1.2 Account Lockout Policy

.DESCRIPTION
This command will test all the settings defined in section 1.2 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level.

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, at the risk of breaking some functionality. This level requires and includes all the Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments that can support them.

.EXAMPLE
Test-AccountPoliciesAccountLockoutPolicy

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.2.1     (L1) Ensure 'Account lockout duration' is set to '15 or more minute(s)'                             Group Policy Settings     True    
1.2.2     (L1) Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'  Group Policy Settings     True    
1.2.3     (L1) Ensure 'Allow Administrator account lockout' is set to 'Enabled'                               Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AccountPoliciesAccountLockoutPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    Test-AccountLockoutPolicyLockoutDuration -ProductType $ProductType -GPResult $GPResult
    Test-AccountLockoutPolicyLockoutThreshold -ProductType $ProductType -GPResult $GPResult
    if ($ProductType -eq 3) {
        Test-AccountLockoutPolicyAdminLockout -ProductType $ProductType -GPResult $GPResult
    }
    Test-AccountLockoutPolicyResetLockoutCount -ProductType $ProductType -GPResult $GPResult

}

<#
.SYNOPSIS
1 Account Policies

.DESCRIPTION
This command will test all the settings defined in section 1 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level.

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, at the risk of breaking some functionality. This level requires and includes all the Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments that can support them.

.EXAMPLE
Test-CISBenchmarkAccountPolicies

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.1.1     (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'                           Group Policy Settings     True    
1.1.2     (L1) Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'                         Group Policy Settings     True    
1.1.3     (L1) Ensure 'Minimum password age' is set to '1 or more day(s)'                                     Group Policy Settings     True    

.NOTES
General notes
#>
function Test-CISBenchmarkAccountPolicies {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    Test-AccountPoliciesPasswordPolicy -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    Test-AccountPoliciesAccountLockoutPolicy -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
}

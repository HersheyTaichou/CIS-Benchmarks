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

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountPoliciesAccountLockoutPolicy

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.2.1      L1    Ensure 'Account lockout duration' is set to '15 or more minu... Group Policy Settings     True        
1.2.2      L1    Ensure 'Account lockout threshold' is set to '5 or fewer inv... Group Policy Settings     True        
1.2.4      L1    Ensure 'Reset account lockout counter after' is set to '15 o... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountPoliciesAccountLockoutPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }
    Process {
        Test-AccountLockoutPolicyLockoutDuration @Parameters
        Test-AccountLockoutPolicyLockoutThreshold @Parameters
        if ($ProductType.Number -eq 3) {
            Test-AccountLockoutPolicyAdminLockout @Parameters
        }
        Test-AccountLockoutPolicyResetLockoutCount @Parameters
    }

}

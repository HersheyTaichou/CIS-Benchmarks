<#
.SYNOPSIS
2.2 User Rights Assignment

.DESCRIPTION
This command will test all the settings defined in section 2.2 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-LocalPoliciesUserRightsAssignment

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.1     (L1) Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'                      Group Policy Settings     True    
2.2.2     (L1) Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Use... Group Policy Settings     True    
2.2.4     (L1) Ensure 'Act as part of the operating system' is set to 'No One'                                Group Policy Settings     True    

.NOTES
General notes
#>
function Test-LocalPoliciesUserRightsAssignment {
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
        Test-UserRightsAssignmentSeTrustedCredManAccessPrivilege @Parameters
        Test-UserRightsAssignmentSeNetworkLogonRight @Parameters
        Test-UserRightsAssignmentSeTcbPrivilege @Parameters
        if ($ProductType.Number -eq 2) {
            Test-UserRightsAssignmentSeMachineAccountPrivilege @Parameters
        }
        Test-UserRightsAssignmentSeIncreaseQuotaPrivilege @Parameters
        Test-UserRightsAssignmentSeInteractiveLogonRight @Parameters
        Test-UserRightsAssignmentSeRemoteInteractiveLogonRight @Parameters
        Test-UserRightsAssignmentSeBackupPrivilege @Parameters
        Test-UserRightsAssignmentSeSystemTimePrivilege @Parameters
        Test-UserRightsAssignmentSeTimeZonePrivilege @Parameters
        Test-UserRightsAssignmentSeCreatePagefilePrivilege @Parameters
        Test-UserRightsAssignmentSeCreateTokenPrivilege @Parameters
        Test-UserRightsAssignmentSeCreateGlobalPrivilege @Parameters
        Test-UserRightsAssignmentSeCreatePermanentPrivilege @Parameters
        Test-UserRightsAssignmentSeCreateSymbolicLinkPrivilege @Parameters
        Test-UserRightsAssignmentSeDebugPrivilege @Parameters
        Test-UserRightsAssignmentSeDenyNetworkLogonRight @Parameters
        Test-UserRightsAssignmentSeDenyBatchLogonRight @Parameters
        Test-UserRightsAssignmentSeDenyServiceLogonRight @Parameters
        Test-UserRightsAssignmentSeDenyInteractiveLogonRight @Parameters
        Test-UserRightsAssignmentSeDenyRemoteInteractiveLogonRight @Parameters
        Test-UserRightsAssignmentSeEnableDelegationPrivilege @Parameters
        Test-UserRightsAssignmentSeRemoteShutdownPrivilege @Parameters
        Test-UserRightsAssignmentSeAuditPrivilege @Parameters
        Test-UserRightsAssignmentSeImpersonatePrivilege @Parameters
        Test-UserRightsAssignmentSeIncreaseBasePriorityPrivilege @Parameters
        Test-UserRightsAssignmentSeLoadDriverPrivilege @Parameters
        Test-UserRightsAssignmentSeLockMemoryPrivilege @Parameters
        if ($ProductType.Number -eq 2 -and $Level -eq 2) {
            Test-UserRightsAssignmentSeBatchLogonRight @Parameters
        }
        Test-UserRightsAssignmentSeSecurityPrivilege @Parameters
        Test-UserRightsAssignmentSeRelabelPrivilege @Parameters
        Test-UserRightsAssignmentSeSystemEnvironmentPrivilege @Parameters
        Test-UserRightsAssignmentSeManageVolumePrivilege @Parameters
        Test-UserRightsAssignmentSeProfileSingleProcessPrivilege @Parameters
        Test-UserRightsAssignmentSeSystemProfilePrivilege @Parameters
        Test-UserRightsAssignmentSeAssignPrimaryTokenPrivilege @Parameters
        Test-UserRightsAssignmentSeRestorePrivilege @Parameters
        Test-UserRightsAssignmentSeShutdownPrivilege @Parameters
        if ($ProductType.Number -eq 2) {
            Test-UserRightsAssignmentSeSyncAgentPrivilege @Parameters
        }
        Test-UserRightsAssignmentSeTakeOwnershipPrivilege @Parameters
    }
}

<#
.SYNOPSIS
2.3 Security Options

.DESCRIPTION
This command will test all the settings defined in section 2.3 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-LocalPoliciesSecurityOptions -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.1.1   (L1) Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Micro... Group Policy Settings     True    
2.3.1.3   (L1) Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set ... Group Policy Settings     True    
2.3.1.4   (L1) Configure 'Accounts: Rename administrator account'                                             Group Policy Settings     True    

.NOTES
General notes
#>
function Test-LocalPoliciesSecurityOptions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    begin {
        $Parameters = @{
            "Level" = $Level
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
        if ($NextGenerationWindowsSecurity) {
            $Parameters += @{
                "NextGenerationWindowsSecurity" = $NextGenerationWindowsSecurity
            }
        }
    }
    Process {
        Test-SecurityOptionsAccounts @Parameters
        Test-SecurityOptionsAudit @Parameters
        Test-SecurityOptionsDevices @Parameters
        if ($ProductType.Number -eq 2) {
            Test-SecurityOptionsDomainController @Parameters
        }
        Test-SecurityOptionsDomainMember @Parameters
        Test-SecurityOptionsInteractiveLogin @Parameters
        Test-SecurityOptionsMicrosoftNetworkClient @Parameters
        Test-SecurityOptionsMicrosoftNetworkServer @Parameters
        Test-SecurityOptionsNetworkAccess @Parameters
        Test-SecurityOptionsNetworkSecurity @Parameters
        Test-SecurityOptionsShutdown @Parameters
        Test-SecurityOptionsSystemObjects @Parameters
        Test-SecurityOptionsUserAccountControl @Parameters
    }
}


<#
.SYNOPSIS
2 Local Policies

.DESCRIPTION
This command will test all the settings defined in section 2 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-CISBenchmarkLocalPolicies

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.1.1   (L1) Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Micro... Group Policy Settings     True    
2.3.1.3   (L1) Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set ... Group Policy Settings     True    
2.3.1.4   (L1) Configure 'Accounts: Rename administrator account'                                             Group Policy Settings     True    

.NOTES
General notes
#>
function Test-CISBenchmarkLocalPolicies {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "Level" = $Level
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
        if ($NextGenerationWindowsSecurity) {
            $Parameters += @{
                "NextGenerationWindowsSecurity" = $NextGenerationWindowsSecurity
            }
        }
    }
    Process {
        Test-LocalPoliciesUserRightsAssignment @Parameters
        Test-LocalPoliciesSecurityOptions @Parameters
    }
}

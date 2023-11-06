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

.EXAMPLE
Test-LocalPoliciesUserRightsAssignment

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
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
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    Test-UserRightsAssignmentSeTrustedCredManAccessPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeNetworkLogonRight -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeTcbPrivilege -ProductType $ProductType -GPResult $GPResult
    if ($ProductType -eq 2) {
        Test-UserRightsAssignmentSeMachineAccountPrivilege -ProductType $ProductType -GPResult $GPResult
    }
    Test-UserRightsAssignmentSeIncreaseQuotaPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeInteractiveLogonRight -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeRemoteInteractiveLogonRight -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeBackupPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeSystemTimePrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeTimeZonePrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeCreatePagefilePrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeCreateTokenPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeCreateGlobalPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeCreatePermanentPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeCreateSymbolicLinkPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeDebugPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeDenyNetworkLogonRight -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeDenyBatchLogonRight -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeDenyServiceLogonRight -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeDenyInteractiveLogonRight -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeDenyRemoteInteractiveLogonRight -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeEnableDelegationPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeRemoteShutdownPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeAuditPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeImpersonatePrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeIncreaseBasePriorityPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeLoadDriverPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeLockMemoryPrivilege -ProductType $ProductType -GPResult $GPResult
    if ($ProductType -eq 2 -and $Level -eq 2) {
        Test-UserRightsAssignmentSeBatchLogonRight -ProductType $ProductType -GPResult $GPResult
    }
    Test-UserRightsAssignmentSeSecurityPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeRelabelPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeSystemEnvironmentPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeManageVolumePrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeProfileSingleProcessPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeSystemProfilePrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeAssignPrimaryTokenPrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeRestorePrivilege -ProductType $ProductType -GPResult $GPResult
    Test-UserRightsAssignmentSeShutdownPrivilege -ProductType $ProductType -GPResult $GPResult
    if ($ProductType -eq 2) {
        Test-UserRightsAssignmentSeSyncAgentPrivilege -ProductType $ProductType -GPResult $GPResult
    }
    Test-UserRightsAssignmentSeTakeOwnershipPrivilege -ProductType $ProductType -GPResult $GPResult
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

.EXAMPLE
Test-LocalPoliciesSecurityOptions -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
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
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    Test-SecurityOptionsAccounts -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    Test-SecurityOptionsAudit -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    Test-SecurityOptionsDevices -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    if ($ProductType -eq 2) {
        Test-SecurityOptionsDomainController -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    }
    Test-SecurityOptionsDomainMember -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    Test-SecurityOptionsInteractiveLogin -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    Test-SecurityOptionsMicrosoftNetworkClient -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    Test-SecurityOptionsMicrosoftNetworkServer -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    Test-SecurityOptionsNetworkAccess -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    Test-SecurityOptionsNetworkSecurity -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    Test-SecurityOptionsShutdown -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    Test-SecurityOptionsSystemObjects -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    Test-SecurityOptionsUserAccountControl -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
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

.EXAMPLE
Test-CISBenchmarkLocalPolicies

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
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
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    Test-LocalPoliciesUserRightsAssignment -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    Test-LocalPoliciesSecurityOptions -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
}

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
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    $ServerType = Get-ProductType

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    Test-UserRightsAssignmentSeTrustedCredManAccessPrivilege
    Test-UserRightsAssignmentSeNetworkLogonRight
    Test-UserRightsAssignmentSeTcbPrivilege
    if ($ServerType -eq 2) {
        Test-UserRightsAssignmentSeMachineAccountPrivilege
    }
    Test-UserRightsAssignmentSeIncreaseQuotaPrivilege
    Test-UserRightsAssignmentSeInteractiveLogonRight
    Test-UserRightsAssignmentSeRemoteInteractiveLogonRight
    Test-UserRightsAssignmentSeBackupPrivilege
    Test-UserRightsAssignmentSeSystemTimePrivilege
    Test-UserRightsAssignmentSeTimeZonePrivilege
    Test-UserRightsAssignmentSeCreatePagefilePrivilege
    Test-UserRightsAssignmentSeCreateTokenPrivilege
    Test-UserRightsAssignmentSeCreateGlobalPrivilege
    Test-UserRightsAssignmentSeCreatePermanentPrivilege
    Test-UserRightsAssignmentSeCreateSymbolicLinkPrivilege
    Test-UserRightsAssignmentSeDebugPrivilege
    Test-UserRightsAssignmentSeDenyNetworkLogonRight
    Test-UserRightsAssignmentSeDenyBatchLogonRight
    Test-UserRightsAssignmentSeDenyServiceLogonRight
    Test-UserRightsAssignmentSeDenyInteractiveLogonRight
    Test-UserRightsAssignmentSeDenyRemoteInteractiveLogonRight
    Test-UserRightsAssignmentSeEnableDelegationPrivilege
    Test-UserRightsAssignmentSeRemoteShutdownPrivilege
    Test-UserRightsAssignmentSeAuditPrivilege
    Test-UserRightsAssignmentSeImpersonatePrivilege
    Test-UserRightsAssignmentSeIncreaseBasePriorityPrivilege
    Test-UserRightsAssignmentSeLoadDriverPrivilege
    Test-UserRightsAssignmentSeLockMemoryPrivilege
    if ($ServerType -eq 2 -and $Level -eq 2) {
        Test-UserRightsAssignmentSeBatchLogonRight
    }
    Test-UserRightsAssignmentSeSecurityPrivilege
    Test-UserRightsAssignmentSeRelabelPrivilege
    Test-UserRightsAssignmentSeSystemEnvironmentPrivilege
    Test-UserRightsAssignmentSeManageVolumePrivilege
    Test-UserRightsAssignmentSeProfileSingleProcessPrivilege
    Test-UserRightsAssignmentSeSystemProfilePrivilege
    Test-UserRightsAssignmentSeAssignPrimaryTokenPrivilege
    Test-UserRightsAssignmentSeRestorePrivilege
    Test-UserRightsAssignmentSeShutdownPrivilege
    if ($ServerType -eq 2) {
        Test-UserRightsAssignmentSeSyncAgentPrivilege
    }
    Test-UserRightsAssignmentSeTakeOwnershipPrivilege
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
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    $ServerType = Get-ProductType

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    Test-SecurityOptionsAccounts -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-SecurityOptionsAudit -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-SecurityOptionsDevices -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    if ($ServerType -eq 2) {
        Test-SecurityOptionsDomainController -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    }
    Test-SecurityOptionsDomainMember -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-SecurityOptionsInteractiveLogin -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-SecurityOptionsMicrosoftNetworkClient -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-SecurityOptionsMicrosoftNetworkServer -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-SecurityOptionsNetworkAccess -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-SecurityOptionsNetworkSecurity -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-SecurityOptionsShutdown -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-SecurityOptionsSystemObjects -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-SecurityOptionsUserAccountControl -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
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
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    Test-LocalPoliciesUserRightsAssignment -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-LocalPoliciesSecurityOptions -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
}

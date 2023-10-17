<#
.SYNOPSIS
2.2 User Rights Assignment

.DESCRIPTION
This command will test for the 48 settings defined in section 2.2 of the 
CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level. 

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, 
at the risk of breaking some functionality. This level requires and includes all the
Level 1 benchmarks

.PARAMETER ServerType
This parameter is used to define the type of server this is running on.

The valid options are:
DomainController    = These settings are specific to Domain Controllers.
MemberServer        = These settings are specific to domain member servers. 

The MemberServer profile also applies to servers with the following roles:
- AD Certificate Services
- DHCP Server
- DNS Server
- File Server
- Hyper-V
- Network Policy and Access Services
- Print Server
- Remote Access Services
- Remote Desktop Services
- Web Server

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments taht can support them.

.EXAMPLE
An example

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
This command will test for the # settings defined in section 2.3 of the 
CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level. 

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, 
at the risk of breaking some functionality. This level requires and includes all the
Level 1 benchmarks

.PARAMETER ServerType
This parameter is used to define the type of server this is running on.

The valid options are:
DomainController    = These settings are specific to Domain Controllers.
MemberServer        = These settings are specific to domain member servers. 

The MemberServer profile also applies to servers with the following roles:
- AD Certificate Services
- DHCP Server
- DNS Server
- File Server
- Hyper-V
- Network Policy and Access Services
- Print Server
- Remote Access Services
- Remote Desktop Services
- Web Server

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments taht can support them.

.EXAMPLE
An example

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
This command will test for all the settings defined in section 2 of the 
CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level. 

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, 
at the risk of breaking some functionality. This level requires and includes all the
Level 1 benchmarks

.PARAMETER ServerType
This parameter is used to define the type of server this is running on.

The valid options are:
DomainController    = These settings are specific to Domain Controllers.
MemberServer        = These settings are specific to domain member servers. 

The MemberServer profile also applies to servers with the following roles:
- AD Certificate Services
- DHCP Server
- DNS Server
- File Server
- Hyper-V
- Network Policy and Access Services
- Print Server
- Remote Access Services
- Remote Desktop Services
- Web Server

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments taht can support them.

.EXAMPLE
An example

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

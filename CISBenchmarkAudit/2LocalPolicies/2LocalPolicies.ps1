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
        [Parameter(Mandatory=$true)][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    $Result = @()

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    $Result += Test-UserRightsAssignmentSeTrustedCredManAccessPrivilege
    $Result += Test-UserRightsAssignmentSeNetworkLogonRight
    $Result += Test-UserRightsAssignmentSeTcbPrivilege
    if ($ServerType -eq "DomainController") {
        $Result += Test-UserRightsAssignmentSeMachineAccountPrivilege
    }
    $Result += Test-UserRightsAssignmentSeIncreaseQuotaPrivilege
    $Result += Test-UserRightsAssignmentSeIncreaseQuotaPrivilege
    $Result += Test-UserRightsAssignmentSeInteractiveLogonRight
    $Result += Test-UserRightsAssignmentSeRemoteInteractiveLogonRight
    $Result += Test-UserRightsAssignmentSeBackupPrivilege
    $Result += Test-UserRightsAssignmentSeSystemTimePrivilege
    $Result += Test-UserRightsAssignmentSeTimeZonePrivilege
    $Result += Test-UserRightsAssignmentSeCreatePagefilePrivilege
    $Result += Test-UserRightsAssignmentSeCreateTokenPrivilege
    $Result += Test-UserRightsAssignmentSeCreateGlobalPrivilege
    $Result += Test-UserRightsAssignmentSeCreatePermanentPrivilege
    $Result += Test-UserRightsAssignmentSeCreateSymbolicLinkPrivilege
    $Result += Test-UserRightsAssignmentSeDebugPrivilege
    $Result += Test-UserRightsAssignmentSeDenyNetworkLogonRight
    $Result += Test-UserRightsAssignmentSeDenyBatchLogonRight
    $Result += Test-UserRightsAssignmentSeDenyServiceLogonRight
    $Result += Test-UserRightsAssignmentSeDenyInteractiveLogonRight
    $Result += Test-UserRightsAssignmentSeDenyRemoteInteractiveLogonRight
    $Result += Test-UserRightsAssignmentSeEnableDelegationPrivilege
    $Result += Test-UserRightsAssignmentSeRemoteShutdownPrivilege
    $Result += Test-UserRightsAssignmentSeAuditPrivilege
    $Result += Test-UserRightsAssignmentSeImpersonatePrivilege
    $Result += Test-UserRightsAssignmentSeIncreaseBasePriorityPrivilege
    $Result += Test-UserRightsAssignmentSeLoadDriverPrivilege
    $Result += Test-UserRightsAssignmentSeLockMemoryPrivilege
    if ($ServerType -eq "DomainController" -and $Level -eq 2) {
        $Result += Test-UserRightsAssignmentSeBatchLogonRight
    }
    $Result += Test-UserRightsAssignmentSeSecurityPrivilege
    $Result += Test-UserRightsAssignmentSeRelabelPrivilege
    $Result += Test-UserRightsAssignmentSeSystemEnvironmentPrivilege
    $Result += Test-UserRightsAssignmentSeManageVolumePrivilege
    $Result += Test-UserRightsAssignmentSeProfileSingleProcessPrivilege
    $Result += Test-UserRightsAssignmentSeSystemProfilePrivilege
    $Result += Test-UserRightsAssignmentSeAssignPrimaryTokenPrivilege
    $Result += Test-UserRightsAssignmentSeRestorePrivilege
    $Result += Test-UserRightsAssignmentSeShutdownPrivilege
    if ($ServerType -eq "DomainController") {
        $Result += Test-UserRightsAssignmentSeSyncAgentPrivilege
    }
    $Result += Test-UserRightsAssignmentSeTakeOwnershipPrivilege

    return $Result
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
        [Parameter(Mandatory=$true)][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    $Result = @()

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    $Result += Test-SecurityOptionsAccounts -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    $Result += Test-SecurityOptionsAudit -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    $Result += Test-SecurityOptionsDevices -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    if (-ServerType -eq "DomainController") {
        $Result += Test-SecurityOptionsDomainController -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    }
    $Result += Test-SecurityOptionsDomainMember -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    $Result += Test-SecurityOptionsInteractiveLogin -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    $Result += Test-SecurityOptionsMicrosoftNetworkClient -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    $Result += Test-SecurityOptionsMicrosoftNetworkServer -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    $Result += Test-SecurityOptionsNetworkAccess -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    $Result += Test-SecurityOptionsNetworkSecurity -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    $Result += Test-SecurityOptionsShutdown -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    $Result += Test-SecurityOptionsSystemObjects -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    $Result += Test-SecurityOptionsUserAccountControl -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity

    return $Result
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
        [Parameter(Mandatory=$true)][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    $Result = @()

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    $Result += Test-LocalPoliciesUserRightsAssignment -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    $Result += Test-LocalPoliciesSecurityOptions -Level $Level -ServerType $ServerType -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity

    return $Result
}

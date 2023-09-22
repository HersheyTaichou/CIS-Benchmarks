. $PSScriptRoot\1.1PasswordPolicy\1.1PasswordPolicy.ps1
. $PSScriptRoot\1.2AccountLockoutPolicy\1.2AccountLockoutPolicy.ps1

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
2 = Level 2 of the benchmark. This is intended to provide a higher level of security, at the risk of breaking some functionality.

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
Test-PasswordPolicy -Level 1 -ServerType DomainController

.NOTES
General notes
#>
function Test-PasswordPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter(Mandatory=$true)][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    $Result = @()

    $Result += Test-PasswordHistory
    $Result += Test-MaxPasswordAge
    $Result += Test-MinPasswordAge
    $Result += Test-MinPasswordLength
    $Result += Test-ComplexityEnabled
    if ($ServerType = "MemberServer") {
        $Result += Test-RelaxMinimumPasswordLengthLimits
    }
    $Result += Test-ReversibleEncryption

    return $Result
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
2 = Level 2 of the benchmark. This is intended to provide a higher level of security, at the risk of breaking some functionality.

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
function Test-AccountLockoutPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter(Mandatory=$true)][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    $Result = @()

    $Result += Test-LockoutDuration
    $Result += Test-LockoutThreshold
    if ($ServerType = "MemberServer") {
        $Result += Test-AdminLockout
    }
    $Result += Test-ResetLockoutCount

    return $Result
}
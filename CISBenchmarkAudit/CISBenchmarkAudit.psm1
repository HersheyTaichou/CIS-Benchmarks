#Requires -RunAsAdministrator

<#
.SYNOPSIS
CIS Microsoft Windows Server 2022 Benchmark v2.0.0

.DESCRIPTION
This command will test all the settings defined the 
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
function Test-CISBenchmark {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter(Mandatory=$true)][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    $Return = @()

    $Return += Test-CISBenchmarkAccountPolicies -ServerType $ServerType -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    $Return += Test-CISBenchmarkLocalPolicies -ServerType $ServerType -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity

    return $Return
}
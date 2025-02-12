<#
.SYNOPSIS
CIS Microsoft Windows Server 2022 Benchmark v2.0.0

.DESCRIPTION
This command will test all the settings defined in the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-CISBenchmark -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.1.1     (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'                           Group Policy Settings     True
1.1.1     (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'                           Test Policy Fine Grain... True

.NOTES
General notes
#>
function Test-CISBenchmark {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        #[Parameter()][switch]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "Level" = $Level
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        # 1 Account Policies
        Test-CISBenchmarkAccountPolicy @Parameters
        # 2 Local Policies
        #Test-CISBenchmarkLocalPolicies @Parameters
        # 5 System Services
        #Test-CISBenchmarkSystemServices @Parameters
        # 9 Windows Defender Firewall with Advanced Security
        #Test-CISBenchmarkWindowsDefenderFirewallwithAdvancedSecurity @Parameters
        # 17 Advanced Audit Policy Configuration
        #Test-CISBenchmarkAdvancedAuditPolicyConfiguration @Parameters
        # 18 Administrative Templates (Computer)
        #Test-CISBenchmarkAdministrativeTemplatesComputer @Parameters -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        # 19 Administrative Templates (User)
        #Test-CISBenchmarkAdministrativeTemplatesUser @Parameters
    }
}

#Requires -RunAsAdministrator

<#
.SYNOPSIS
CIS Microsoft Windows Server 2022 Benchmark v2.0.0

.DESCRIPTION
This command will test all the settings defined in the 
CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level. 

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, 
at the risk of breaking some functionality. This level requires and includes all the
Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments that can support them.

.EXAMPLE
Test-CISBenchmark -Level 1

RecommendationNumber  RecommendationName                                                   Source                    Result
--------------------  ------------------                                                   ------                    ------
1.1.1                 Ensure 'Enforce password history' is set to '24 or more password(s)' Group Policy Settings     True
1.1.1                 Ensure 'Enforce password history' is set to '24 or more password(s)' Test Policy Fine Grain... True

.NOTES
General notes
#>
function Test-CISBenchmark {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    $Return = @()

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    Test-CISBenchmarkAccountPolicies -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-CISBenchmarkLocalPolicies -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    Test-CISBenchmarkSystemServices -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity

    return $Return
}


<#
.SYNOPSIS

.DESCRIPTION
This command will test all the settings defined in section 18 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level.

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, at the risk of breaking some functionality. This level requires and includes all the Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments that can support them.

.EXAMPLE


Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-StartMenuAndTaskbarNotifications {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
    }
}

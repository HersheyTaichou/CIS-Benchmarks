<#
.SYNOPSIS
5.1 (L1) Ensure 'Print Spooler (Spooler)' is set to 'Disabled' (DC only)
5.2 (L2) Ensure 'Print Spooler (Spooler)' is set to 'Disabled' (MS only)

.DESCRIPTION
This service spools print jobs and handles interaction with printers.

.EXAMPLE
Test-SystemServicesSpooler

Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    
5.1                   (L1) Ensure 'Print Spooler (Spooler)' is set to 'Disabled' (DC only)                                Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SystemServicesSpooler {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Spooler"
        $Result.Number = '5.1'
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        $ProductType = Get-ProductType
    }

    process {
        if ($ProductType -eq 2) {
            $ProfileApplicability = @("Level 1 - Domain Controller")
            $Result.Title = "Ensure 'Print Spooler (Spooler)' is set to 'Disabled' (DC only)"
            $Result.Setting = $Result.Entry.StartupMode
            if ($Result.Setting -eq "Disabled") {
                $Result.SetCorrectly = $True
            } else {
                $Result.SetCorrectly = $false
            }
        } elseif ($ProductType -eq 3) {
            $ProfileApplicability = @("Level 2 - Member Server")
            $RecommendationName = "(L2) Ensure 'Print Spooler (Spooler)' is set to 'Disabled' (MS only)"
            $Result.Setting = $Result.Entry.StartupMode
            if ($Result.Setting -eq "Disabled") {
                $Result.SetCorrectly = $True
            } else {
                $Result.SetCorrectly = $false
            }
        }
    }

    end {
        
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
5 System Services

.DESCRIPTION
This command will test all the settings defined in section 5 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level.

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, at the risk of breaking some functionality. This level requires and includes all the Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments that can support them.

.EXAMPLE
Test-CISBenchmarkSystemServices

Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    
5.1                   (L1) Ensure 'Print Spooler (Spooler)' is set to 'Disabled' (DC only)                                Group Policy Settings     True    

.NOTES
General notes
#>
function Test-CISBenchmarkSystemServices {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        
    }
    
    process {
        Test-SystemServicesSpooler -ProductType $ProductType -GPResult $GPResult
    }
    
    end {}
}

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
    param ()

    begin {
        $Return = @()
        $EntryName = "Spooler"
        $RecommendationNumber = '5.1'
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name"
        $ProductType = Get-ProductType
    }

    process {
        if ($ProductType -eq 2) {
            $ProfileApplicability = @("Level 1 - Domain Controller")
            $RecommendationName = "(L1) Ensure 'Print Spooler (Spooler)' is set to 'Disabled' (DC only)"
            $Setting = $Entry.StartupMode
            if ($Setting -eq "Disabled") {
                $Pass = $True
            } else {
                $Pass = $false
            }
        } elseif ($ProductType -eq 3) {
            $ProfileApplicability = @("Level 2 - Member Server")
            $RecommendationName = "(L2) Ensure 'Print Spooler (Spooler)' is set to 'Disabled' (MS only)"
            $Setting = $Entry.StartupMode
            if ($Setting -eq "Disabled") {
                $Pass = $True
            } else {
                $Pass = $false
            }
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-CISBenchmarkSystemServices {
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
        Test-SystemServicesSpooler
    }
    
    end {}
}

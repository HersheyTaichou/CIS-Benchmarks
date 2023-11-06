<#
.SYNOPSIS
2.3.13.1 (L1) Ensure 'Shutdown: Allow system to be shut down without having to log on' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether a computer can be shut down when a user is not logged on.

.EXAMPLE
Test-ShutdownShutdownWithoutLogon

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.13.1  (L1) Ensure 'Shutdown: Allow system to be shut down without having to log on' is set to 'Disabled'  Group Policy Settings     True    

.NOTES
General notes
#>
function Test-ShutdownShutdownWithoutLogon {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ShutdownWithoutLogon"
        $RecommendationNumber = '2.3.13.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Shutdown: Allow system to be shut down without having to log on' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.KeyName) {
            $Pass = -not($setting)
        } else {
            $Pass = $false
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

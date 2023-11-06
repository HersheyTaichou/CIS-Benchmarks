<#
.SYNOPSIS
18.1.2.2 (L1) Ensure 'Allow users to enable online speech recognition services' is set to 'Disabled'

.DESCRIPTION
This policy enables the automatic learning component of input personalization that includes speech, inking, and typing. Automatic learning enables the collection of speech and handwriting patterns, typing history, contacts, and recent calendar information.

.EXAMPLE
Test-RegionalAndLanguageOptionsAllowUsersToEnableOnlineSpeechRecognitionServices

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  

.NOTES
General notes
#>
function Test-RegionalAndLanguageOptionsAllowUsersToEnableOnlineSpeechRecognitionServices {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Allow users to enable online speech recognition services"
        $RecommendationNumber = '18.1.2.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Allow users to enable online speech recognition services' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        $Setting = $Entry.State
        if ($Setting -eq "Disabled") {
            $Pass = $true
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

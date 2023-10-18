function Test-SystemServices {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = ""
        $RecommendationNumber = '5.1'
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
        $ProductType = Get-ProductType
    }

    process {
        if ($ProductType -eq 2) {
            $ProfileApplicability = @("Level 1 - Domain Controller")
            $RecommendationName = "(L1) Ensure 'Print Spooler (Spooler)' is set to 'Disabled' (DC only)"
        } elseif ($ProductType -eq 3) {
            $ProfileApplicability = @("Level 2 - Member Server")
            $RecommendationName = "(L2) Ensure 'Print Spooler (Spooler)' is set to 'Disabled' (MS only)"
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
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

function Test-DSAccessAuditDirectoryServiceAccess {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Directory Service Access"
        $RecommendationNumber = '17.4.1'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Audit Directory Service Access' is set to include 'Failure' (DC only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName"
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if (($Setting -eq 2) -or ($Setting -eq 3)) {
            $Pass = $true
        } else {
            $Pass = $false
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

function Test-DSAccessAuditDirectoryServiceChanges {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Directory Service Changes"
        $RecommendationNumber = '17.4.2'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Audit Directory Service Changes' is set to include 'Success' (DC only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName"
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if (($Setting -eq 1) -or ($Setting -eq 3)) {
            $Pass = $true
        } else {
            $Pass = $false
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

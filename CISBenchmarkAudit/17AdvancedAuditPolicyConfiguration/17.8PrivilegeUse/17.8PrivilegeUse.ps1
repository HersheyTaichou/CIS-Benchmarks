function Test-PrivilegeUseAuditSensitivePrivilegeUse {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Sensitive Privilege Use"
        $RecommendationNumber = '17.8.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Sensitive Privilege Use' is set to 'Success and Failure'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName"
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if ($Setting -eq 3) {
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

function Test-AccountManagementAuditApplicationGroupManagement {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Application Group Management"
        $RecommendationNumber = '17.2.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Application Group Management' is set to 'Success and Failure'"
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

function Test-AccountManagementAuditComputerAccountManagement {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Computer Account Management"
        $RecommendationNumber = '17.2.2'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = ""
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

function Test-AccountManagementAuditDistributionGroupManagement {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = ""
        $RecommendationNumber = '17.2.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Distribution Group Management' is set to include 'Success' (DC only)"
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

function Test-AccountManagementAuditOtherAccountManagementEvents {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = ""
        $RecommendationNumber = '17.2.4'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Audit Other Account Management Events' is set to include 'Success' (DC only)"
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

function Test-AccountManagementAuditSecurityGroupManagement {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Security Group Management"
        $RecommendationNumber = '17.2.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Security Group Management' is set to include 'Success'"
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

function Test-AccountManagementAuditUserAccountManagement {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit User Account Management"
        $RecommendationNumber = '17.2.6'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit User Account Management' is set to 'Success and Failure'"
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

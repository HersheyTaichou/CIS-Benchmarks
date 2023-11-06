<#
.SYNOPSIS
17.3.1 (L1) Ensure 'Audit PNP Activity' is set to include 'Success'

.DESCRIPTION
This policy setting allows you to audit when plug and play detects an external device.

.EXAMPLE
Test-DetailedTrackingAuditPNPActivity

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.3.1     (L1) Ensure 'Audit PNP Activity' is set to include 'Success'                Group Policy Settings     True  

.NOTES
General notes
#>
function Test-DetailedTrackingAuditPNPActivity {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit PNP Activity"
        $RecommendationNumber = '17.3.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit PNP Activity' is set to include 'Success'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
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

<#
.SYNOPSIS
17.3.2 (L1) Ensure 'Audit Process Creation' is set to include 'Success'

.DESCRIPTION
This subcategory reports the creation of a process and the name of the program or user that created it.

.EXAMPLE
Test-DetailedTrackingAuditProcessCreation

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.3.2     (L1) Ensure 'Audit Process Creation' is set to include 'Success'            Group Policy Settings     True  

.NOTES
General notes
#>
function Test-DetailedTrackingAuditProcessCreation {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit Process Creation"
        $RecommendationNumber = '17.3.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Process Creation' is set to include 'Success'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
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

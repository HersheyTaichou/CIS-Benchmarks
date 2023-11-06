<#
.SYNOPSIS
17.9.1 (L1) Ensure 'Audit IPsec Driver' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports on the activities of the Internet Protocol security (IPsec) driver.

.EXAMPLE
Test-SystemAuditIPsecDriver

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.9.1     (L1) Ensure 'Audit IPsec Driver' is set to 'Success and Failure'            Group Policy Settings     True  

.NOTES
General notes
#>
function Test-SystemAuditIPsecDriver {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit IPsec Driver"
        $RecommendationNumber = '17.9.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit IPsec Driver' is set to 'Success and Failure'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
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
17.9.2 (L1) Ensure 'Audit Other System Events' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports on other system events

.EXAMPLE
Test-SystemAuditOtherSystemEvents

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.9.2     (L1) Ensure 'Audit Other System Events' is set to 'Success and Failure'     Group Policy Settings     True  

.NOTES
General notes
#>
function Test-SystemAuditOtherSystemEvents {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit Other System Events"
        $RecommendationNumber = '17.9.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Other System Events' is set to 'Success and Failure'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
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
17.9.3 (L1) Ensure 'Audit Security State Change' is set to include 'Success'

.DESCRIPTION
This subcategory reports changes in security state of the system, such as when the security subsystem starts and stops.

.EXAMPLE
Test-SystemAuditSecurityStateChange

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.9.3     (L1) Ensure 'Audit Security State Change' is set to include 'Success'       Group Policy Settings     True  

.NOTES
General notes
#>
function Test-SystemAuditSecurityStateChange {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit Security State Change"
        $RecommendationNumber = '17.9.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Security State Change' is set to include 'Success'"
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
17.9.4 (L1) Ensure 'Audit Security System Extension' is set to include 'Success'

.DESCRIPTION
This subcategory reports the loading of extension code such as authentication packages by the security subsystem.

.EXAMPLE
Test-SystemAuditSecuritySystemExtension

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.9.4     (L1) Ensure 'Audit Security System Extension' is set to include 'Success'   Group Policy Settings     True  

.NOTES
General notes
#>
function Test-SystemAuditSecuritySystemExtension {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit Security System Extension"
        $RecommendationNumber = '17.9.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Security System Extension' is set to include 'Success'"
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
17.9.5 (L1) Ensure 'Audit System Integrity' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports on violations of integrity of the security subsystem.

.EXAMPLE
Test-SystemAuditSystemIntegrity

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.9.5     (L1) Ensure 'Audit System Integrity' is set to 'Success and Failure'        Group Policy Settings     True  

.NOTES
General notes
#>
function Test-SystemAuditSystemIntegrity {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit System Integrity"
        $RecommendationNumber = '17.9.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit System Integrity' is set to 'Success and Failure'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
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

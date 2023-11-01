<#
.SYNOPSIS
17.7.1 (L1) Ensure 'Audit Audit Policy Change' is set to include 'Success'

.DESCRIPTION
This subcategory reports changes in audit policy including SACL changes.

.EXAMPLE
Test-PolicyChangeAuditAuditPolicyChange

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.7.1     (L1) Ensure 'Audit Audit Policy Change' is set to include 'Success'         Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PolicyChangeAuditAuditPolicyChange {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Audit Policy Change"
        $RecommendationNumber = '17.7.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Audit Policy Change' is set to include 'Success'"
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
17.7.2 (L1) Ensure 'Audit Authentication Policy Change' is set to include 'Success'

.DESCRIPTION
This subcategory reports changes in authentication policy.

.EXAMPLE
Test-PolicyChangeAuditAuthenticationPolicyChange

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.7.2     (L1) Ensure 'Audit Authentication Policy Change' is set to include 'Succ... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PolicyChangeAuditAuthenticationPolicyChange {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Authentication Policy Change"
        $RecommendationNumber = '17.7.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Authentication Policy Change' is set to include 'Success'"
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
17.7.3 (L1) Ensure 'Audit Authorization Policy Change' is set to include 'Success'

.DESCRIPTION
This subcategory reports changes in authorization policy.

.EXAMPLE
Test-PolicyChangeAuditAuthorizationPolicyChange

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.7.3     (L1) Ensure 'Audit Authorization Policy Change' is set to include 'Success' Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PolicyChangeAuditAuthorizationPolicyChange {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Authorization Policy Change"
        $RecommendationNumber = '17.7.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Authorization Policy Change' is set to include 'Success'"
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
17.7.4 (L1) Ensure 'Audit MPSSVC Rule-Level Policy Change' is set to 'Success and Failure'

.DESCRIPTION
This subcategory determines whether the operating system generates audit events when changes are made to policy rules for the Microsoft Protection Service (MPSSVC.exe).

.EXAMPLE
Test-PolicyChangeAuditMPSSVCRuleLevelPolicyChange

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.7.4     (L1) Ensure 'Audit MPSSVC Rule-Level Policy Change' is set to 'Success a... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PolicyChangeAuditMPSSVCRuleLevelPolicyChange {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit MPSSVC Rule-Level Policy Change"
        $RecommendationNumber = '17.7.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit MPSSVC Rule-Level Policy Change' is set to 'Success and Failure'"
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
17.7.5 (L1) Ensure 'Audit Other Policy Change Events' is set to include 'Failure'

.DESCRIPTION
This subcategory contains events about EFS Data Recovery Agent policy changes, changes in Windows Filtering Platform filter, status on Security policy settings updates for local Group Policy settings, Central Access Policy changes, and detailed troubleshooting events for Cryptographic Next Generation (CNG) operations.

.EXAMPLE
Test-PolicyChangeAuditOtherPolicyChangeEvents

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.7.5     (L1) Ensure 'Audit Other Policy Change Events' is set to include 'Failure'  Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PolicyChangeAuditOtherPolicyChangeEvents {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Other Policy Change Events"
        $RecommendationNumber = '17.7.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Other Policy Change Events' is set to include 'Failure'"
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

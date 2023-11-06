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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
              $EntryName = "Audit Audit Policy Change"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.7.1"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Audit Policy Change' is set to include 'Success'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingValue
        if (($Result.Setting -eq 1) -or ($Result.Setting -eq 3)) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
              $EntryName = "Audit Authentication Policy Change"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.7.2"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Authentication Policy Change' is set to include 'Success'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingValue
        if (($Result.Setting -eq 1) -or ($Result.Setting -eq 3)) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
              $EntryName = "Audit Authorization Policy Change"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.7.3"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Authorization Policy Change' is set to include 'Success'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingValue
        if (($Result.Setting -eq 1) -or ($Result.Setting -eq 3)) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
              $EntryName = "Audit MPSSVC Rule-Level Policy Change"
        $Result.Number = '17.7.4'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit MPSSVC Rule-Level Policy Change' is set to 'Success and Failure'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingValue
        if ($Result.Setting -eq 3) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
              $EntryName = "Audit Other Policy Change Events"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.7.5"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Other Policy Change Events' is set to include 'Failure'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingValue
        if (($Result.Setting -eq 2) -or ($Result.Setting -eq 3)) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

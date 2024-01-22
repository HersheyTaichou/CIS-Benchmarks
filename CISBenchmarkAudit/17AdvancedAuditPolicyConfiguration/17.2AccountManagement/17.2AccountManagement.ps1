<#
.SYNOPSIS
17.2.1 (L1) Ensure 'Audit Application Group Management' is set to 'Success and Failure'

.DESCRIPTION
This policy setting allows you to audit events generated by changes to application groups such as the following:

- Application group is created, changed, or deleted.
- Member is added or removed from an application group.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountManagementAuditApplicationGroupManagement

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.2.1     L1    Ensure 'Audit Application Group Management' is set to 'Succe... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountManagementAuditApplicationGroupManagement {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
              $EntryName = "Audit Application Group Management"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.2.1"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Application Group Management' is set to 'Success and Failure'"
		$Result.Source = "Group Policy Settings"

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
17.2.2 (L1) Ensure 'Audit Computer Account Management' is set to include 'Success' (DC only)

.DESCRIPTION
This subcategory reports each event of computer account management, such as when a computer account is created, changed, deleted, renamed, disabled, or enabled.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountManagementAuditComputerAccountManagement

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.2.2     L1    Ensure 'Audit Computer Account Management' is set to include... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountManagementAuditComputerAccountManagement {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
              $EntryName = "Audit Computer Account Management"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.2.2"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Computer Account Management' is set to include 'Success' (DC only)"
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
17.2.3 (L1) Ensure 'Audit Distribution Group Management' is set to include 'Success' (DC only)

.DESCRIPTION
This subcategory reports each event of distribution group management, such as when a distribution group is created, changed, or deleted or when a member is added to or removed from a distribution group.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountManagementAuditDistributionGroupManagement

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.2.3     L1    Ensure 'Audit Distribution Group Management' is set to inclu... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountManagementAuditDistributionGroupManagement {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
              $EntryName = "Audit Distribution Group Management"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.2.3"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Distribution Group Management' is set to include 'Success' (DC only)"
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
17.2.4 (L1) Ensure 'Audit Other Account Management Events' is set to include 'Success' (DC only)

.DESCRIPTION
This subcategory reports other account management events.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountManagementAuditOtherAccountManagementEvents

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.2.4     L1    Ensure 'Audit Other Account Management Events' is set to inc... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountManagementAuditOtherAccountManagementEvents {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
              $EntryName = "Audit Other Account Management Events"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.2.4"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Other Account Management Events' is set to include 'Success' (DC only)"
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
17.2.5 (L1) Ensure 'Audit Security Group Management' is set to include 'Success'

.DESCRIPTION
This subcategory reports each event of security group management, such as when a security group is created, changed, or deleted or when a member is added to or removed from a security group.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountManagementAuditSecurityGroupManagement

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.2.5     L1    Ensure 'Audit Security Group Management' is set to include '... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountManagementAuditSecurityGroupManagement {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
              $EntryName = "Audit Security Group Management"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.2.5"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Security Group Management' is set to include 'Success'"
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
17.2.6 (L1) Ensure 'Audit User Account Management' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports each event of user account management, such as when a user account is created, changed, or deleted; a user account is renamed, disabled, or enabled; or a password is set or changed.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountManagementAuditUserAccountManagement

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.2.6     L1    Ensure 'Audit User Account Management' is set to 'Success an... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountManagementAuditUserAccountManagement {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
              $EntryName = "Audit User Account Management"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.2.6"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit User Account Management' is set to 'Success and Failure'"
		$Result.Source = "Group Policy Settings"

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

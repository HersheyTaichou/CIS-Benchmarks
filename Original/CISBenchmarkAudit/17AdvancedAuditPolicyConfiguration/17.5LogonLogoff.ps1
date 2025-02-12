<#
.SYNOPSIS
17.5.1 (L1) Ensure 'Audit Account Lockout' is set to include 'Failure'

.DESCRIPTION
This subcategory reports when a user's account is locked out as a result of too many failed logon attempts.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-LogonLogoffAuditAccountLockout

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.5.1     L1    Ensure 'Audit Account Lockout' is set to include 'Failure'      Group Policy Settings     True        

.NOTES
General notes
#>
function Test-LogonLogoffAuditAccountLockout {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Audit Account Lockout"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.5.1"
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Account Lockout' is set to include 'Failure'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult -Results "ComputerResults"
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

<#
.SYNOPSIS
17.5.2 (L1) Ensure 'Audit Group Membership' is set to include 'Success'

.DESCRIPTION
This policy allows you to audit the group membership information in the user’s logon token. Events in this subcategory are generated on the computer on which a logon session is created. For an interactive logon, the security audit event is generated on the computer that the user logged on to. For a network logon, such as accessing a shared folder on the network, the security audit event is generated on the computer hosting the resource.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-LogonLogoffAuditGroupMembership

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.5.2     L1    Ensure 'Audit Group Membership' is set to include 'Success'     Group Policy Settings     True        

.NOTES
General notes
#>
function Test-LogonLogoffAuditGroupMembership {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Audit Group Membership"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.5.2"
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Group Membership' is set to include 'Success'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult -Results "ComputerResults"
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
17.5.3 (L1) Ensure 'Audit Logoff' is set to include 'Success'

.DESCRIPTION
This subcategory reports when a user logs off from the system. These events occur on the accessed computer.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-LogonLogoffAuditLogoff

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.5.3     L1    Ensure 'Audit Logoff' is set to include 'Success'               Group Policy Settings     True        

.NOTES
General notes
#>
function Test-LogonLogoffAuditLogoff {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Audit Logoff"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.5.3"
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Logoff' is set to include 'Success'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult -Results "ComputerResults"
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
17.5.4 (L1) Ensure 'Audit Logon' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports when a user attempts to log on to the system. These events occur on the accessed computer.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-LogonLogoffAuditLogon

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.5.4     L1    Ensure 'Audit Logon' is set to 'Success and Failure'            Group Policy Settings     True        

.NOTES
General notes
#>
function Test-LogonLogoffAuditLogon {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Audit Logon"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.5.4"
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Logon' is set to 'Success and Failure'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult -Results "ComputerResults"
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
17.5.5 (L1) Ensure 'Audit Other Logon/Logoff Events' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports other logon/logoff-related events, such as Remote Desktop Services session disconnects and reconnects, using RunAs to run processes under a different account, and locking and unlocking a workstation.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-LogonLogoffAuditOtherLogonLogoffEvents

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.5.5     L1    Ensure 'Audit Other Logon/Logoff Events' is set to 'Success ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-LogonLogoffAuditOtherLogonLogoffEvents {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Audit Other Logon/Logoff Events"
        $Result = [CISBenchmark]::new()
        $Result.Number = '17.5.5'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Other Logon/Logoff Events' is set to 'Success and Failure'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult -Results "ComputerResults"
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
17.5.6 (L1) Ensure 'Audit Special Logon' is set to include 'Success'

.DESCRIPTION
This subcategory reports when a special logon is used. A special logon is a logon that has administrator-equivalent privileges and can be used to elevate a process to a higher level.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-LogonLogoffAuditSpecialLogon

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.5.6     L1    Ensure 'Audit Special Logon' is set to include 'Success'        Group Policy Settings     True        

.NOTES
General notes
#>
function Test-LogonLogoffAuditSpecialLogon {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Audit Special Logon"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.5.6"
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Special Logon' is set to include 'Success'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult -Results "ComputerResults"
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

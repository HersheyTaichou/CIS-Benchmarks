<#
.SYNOPSIS
2.3.1.1 (L1) Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'

.DESCRIPTION
This policy setting prevents users from adding new Microsoft accounts on this computer.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountsNoConnectedUser

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.1.1    L1    Ensure 'Accounts: Block Microsoft accounts' is set to 'Users... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountsNoConnectedUser {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $Result.Number = '2.3.1.1'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\NoConnectedUser"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Result.Entry.SettingNumber -eq 3) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Result.Setting = $Result.Entry.Display.DisplayString
            return $Result
    }
}

<#
.SYNOPSIS
2.3.1.2 (L1) Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only)

.DESCRIPTION
This policy setting determines whether the Guest account is enabled or disabled. The Guest account allows unauthenticated network users to gain access to the system.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountsEnableGuestAccount

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.1.2    L1    Ensure 'Accounts: Guest account status' is set to 'Disabled'... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountsEnableGuestAccount {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        $Result.Number = '2.3.1.2'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only)"
        $Result.Source = 'Group Policy Settings'
        # Get the current value of the setting
        $EntryName = "EnableGuestAccount"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SystemAccessPolicyName" -GPResult $GPResult -Results "ComputerResults"
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Result.Setting) {
            $Result.SetCorrectly = $false
        } elseif ($Result.Setting -eq $false) {
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
2.3.1.3 (L1) Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether local accounts that are not password protected can be used to log on from locations other than the physical computer console.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountsLimitBlankPasswordUse

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.1.3    L1    Ensure 'Accounts: Limit local account use of blank passwords... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountsLimitBlankPasswordUse {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\LimitBlankPasswordUse"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.SetCorrectly = [int]$Result.Entry.SettingNumber
    }

    end {
        $Result.Number = '2.3.1.3'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'
        $Result.Setting = $Result.Entry.Display.DisplayString
            return $Result
    }
}

<#
.SYNOPSIS
2.3.1.4 (L1) Configure 'Accounts: Rename administrator account'

.DESCRIPTION
The built-in local administrator account is a well-known account name that attackers will target. It is recommended to choose another name for this account, and to avoid names that denote administrative or elevated access accounts.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountsNewAdministratorName

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.1.4    L1    Configure 'Accounts: Rename administrator account'              Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountsNewAdministratorName {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "NewAdministratorName"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SystemAccessPolicyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if (($Result.Entry) -and ($Result.Entry.SettingString -ne "Administrator")) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Result.Number = '2.3.1.4'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Configure 'Accounts: Rename administrator account'"
        $Result.Source = 'Group Policy Settings'
        $Result.Setting = $Result.Entry.SettingString
            return $Result
    }
}

<#
.SYNOPSIS
2.3.1.5 (L1) Configure 'Accounts: Rename guest account'

.DESCRIPTION
The built-in local guest account is another well-known name to attackers. It is recommended to rename this account to something that does not indicate its purpose. Even if you disable this account, which is recommended, ensure that you rename it for added security.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountsNewGuestName

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.1.5    L1    Configure 'Accounts: Rename guest account'                      Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountsNewGuestName {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "NewGuestName"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SystemAccessPolicyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if (($Result.Entry) -and ($Result.Entry.SettingString -ne "Guest")) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Result.Number = '2.3.1.5'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Configure 'Accounts: Rename guest account'"
        $Result.Source = 'Group Policy Settings'
        $Result.Setting = $Result.Entry.SettingString
            return $Result
    }
}

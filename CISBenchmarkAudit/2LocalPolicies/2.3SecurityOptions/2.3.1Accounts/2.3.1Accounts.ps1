<#
.SYNOPSIS
2.3.1.1 (L1) Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'

.DESCRIPTION
This policy setting prevents users from adding new Microsoft accounts on this computer.

.EXAMPLE
Test-AccountsNoConnectedUser

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.1.1   (L1) Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Micro... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AccountsNoConnectedUser {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $RecommendationNumber = '2.3.1.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\NoConnectedUser"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
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
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Result.SetCorrectly
            'Setting' = $Result.Entry.Display.DisplayString
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.1.2 (L1) Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only)

.DESCRIPTION
This policy setting determines whether the Guest account is enabled or disabled. The Guest account allows unauthenticated network users to gain access to the system.

.EXAMPLE
Test-AccountsEnableGuestAccount

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.1.2   (L1) Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only)                         Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AccountsEnableGuestAccount {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "EnableGuestAccount"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SystemAccessPolicyName" -GPResult $GPResult
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
        $RecommendationNumber = '2.3.1.2'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only)"
        $Source = 'Group Policy Settings'
        
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.1.3 (L1) Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether local accounts that are not password protected can be used to log on from locations other than the physical computer console.

.EXAMPLE
Test-AccountsLimitBlankPasswordUse

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.1.3   (L1) Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set ... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AccountsLimitBlankPasswordUse {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\LimitBlankPasswordUse"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        [bool]$Result.SetCorrectly = [int]$Result.Entry.SettingNumber
    }

    end {
        $RecommendationNumber = '2.3.1.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled'"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Result.SetCorrectly
            'Setting' = $Result.Entry.Display.DisplayString
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.1.4 (L1) Configure 'Accounts: Rename administrator account'

.DESCRIPTION
The built-in local administrator account is a well-known account name that attackers will target. It is recommended to choose another name for this account, and to avoid names that denote administrative or elevated access accounts.

.EXAMPLE
Test-AccountsNewAdministratorName

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.1.4   (L1) Configure 'Accounts: Rename administrator account'                                             Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AccountsNewAdministratorName {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "NewAdministratorName"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SystemAccessPolicyName" -GPResult $GPResult
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
        $RecommendationNumber = '2.3.1.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Configure 'Accounts: Rename administrator account'"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Result.SetCorrectly
            'Setting' = $Result.Entry.SettingString
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.1.5 (L1) Configure 'Accounts: Rename guest account'

.DESCRIPTION
The built-in local guest account is another well-known name to attackers. It is recommended to rename this account to something that does not indicate its purpose. Even if you disable this account, which is recommended, ensure that you rename it for added security.

.EXAMPLE
Test-AccountsNewGuestName

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.1.5   (L1) Configure 'Accounts: Rename guest account'                                                     Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AccountsNewGuestName {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "NewGuestName"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SystemAccessPolicyName" -GPResult $GPResult
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
        $RecommendationNumber = '2.3.1.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Configure 'Accounts: Rename guest account'"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Result.SetCorrectly
            'Setting' = $Result.Entry.SettingString
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Result

        Return $Return
    }
}

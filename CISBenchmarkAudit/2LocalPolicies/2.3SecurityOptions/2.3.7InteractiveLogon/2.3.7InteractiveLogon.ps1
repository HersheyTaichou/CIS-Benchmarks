<#
.SYNOPSIS
2.3.7.1 (L1) Ensure 'Interactive logon: Do not require CTRL+ALT+DEL' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether users must press CTRL+ALT+DEL before they log on.

.EXAMPLE
Test-InteractiveLogonDisableCAD

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.7.1   (L1) Ensure 'Interactive logon: Do not require CTRL+ALT+DEL' is set to 'Disabled'                   Group Policy Settings     True    

.NOTES
General notes
#>
function Test-InteractiveLogonDisableCAD {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\DisableCAD"
        $RecommendationNumber = '2.3.7.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Interactive logon: Do not require CTRL+ALT+DEL' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry) {
            if ($Setting) {
                $Pass = $false
            } elseif ($setting -eq $false) {
                $Pass = $true
            } else {
                $Pass = $false
            }
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
2.3.7.2 (L1) Ensure 'Interactive logon: Don't display last signed-in' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether the account name of the last user to log on to the client computers in your organization will be displayed in each computer's respective Windows logon screen.

.EXAMPLE
Test-InteractiveLogonDontDisplayLastUserName

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.7.2   (L1) Ensure 'Interactive logon: Don't display last signed-in' is set to 'Enabled'                   Group Policy Settings     True    

.NOTES
General notes
#>
function Test-InteractiveLogonDontDisplayLastUserName {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\DontDisplayLastUserName"
        $RecommendationNumber = '2.3.7.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Interactive logon: Don't display last signed-in' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.KeyName) {
            $Pass = $Setting
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
2.3.7.3 (L1) Ensure 'Interactive logon: Machine inactivity limit' is set to '900 or fewer second(s), but not 0'

.DESCRIPTION
Windows notices inactivity of a logon session, and if the amount of inactive time exceeds the inactivity limit, then the screen saver will run, locking the session.

.EXAMPLE
Test-InteractiveLogonInactivityTimeoutSecs

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.7.3   (L1) Ensure 'Interactive logon: Machine inactivity limit' is set to '900 or fewer second(s), but... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-InteractiveLogonInactivityTimeoutSecs {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\InactivityTimeoutSecs"
        $RecommendationNumber = '2.3.7.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Interactive logon: Machine inactivity limit' is set to '900 or fewer second(s), but not 0'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Setting = [int]$Entry.SettingNumber
        if (($Setting -le 900) -and ($Setting -gt 0)) {
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
2.3.7.4 (L1) Configure 'Interactive logon: Message text for users attempting to log on'

.DESCRIPTION
This policy setting specifies a text message that displays to users when they log on.

.EXAMPLE
Test-InteractiveLogonLegalNoticeText

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.7.4   (L1) Configure 'Interactive logon: Message text for users attempting to log on'                     Group Policy Settings     True    

.NOTES
General notes
#>
function Test-InteractiveLogonLegalNoticeText {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\LegalNoticeText"
        $RecommendationNumber = '2.3.7.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Configure 'Interactive logon: Message text for users attempting to log on'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Setting = $Entry.SettingStrings
        if ($Setting) {
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
2.3.7.5 (L1) Configure 'Interactive logon: Message title for users attempting to log on'

.DESCRIPTION
This policy setting specifies the text displayed in the title bar of the window that users see when they log on to the system.

.EXAMPLE
Test-InteractiveLogonLegalNoticeCaption

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.7.5   (L1) Configure 'Interactive logon: Message title for users attempting to log on'                    Group Policy Settings     True    

.NOTES
General notes
#>
function Test-InteractiveLogonLegalNoticeCaption {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\LegalNoticeCaption"
        $RecommendationNumber = '2.3.7.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Configure 'Interactive logon: Message title for users attempting to log on'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Setting = $Entry.SettingString
        if ($Setting) {
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
2.3.7.6 (L2) Ensure 'Interactive logon: Number of previous logons to cache (in case domain controller is not available)' is set to '4 or fewer logon(s)' (MS only)

.DESCRIPTION
This policy setting determines whether a user can log on to a Windows domain using cached account information.

.EXAMPLE
Test-InteractiveLogonCachedLogonsCount

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.7.6   (L2) Ensure 'Interactive logon: Number of previous logons to cache (in case domain controller is... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-InteractiveLogonCachedLogonsCount {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\CachedLogonsCount"
        $RecommendationNumber = '2.3.7.6'
        $ProfileApplicability = @("Level 2 - Member Server")
        $RecommendationName = "(L2) Ensure 'Interactive logon: Number of previous logons to cache (in case domain controller is not available)' is set to '4 or fewer logon(s)' (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Setting = [int]$Entry.SettingString
        # If $Setting is null, this would pass, without have the test to make sure $Setting exists
        if (($Setting -le 4) -and ($Setting)) {
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
2.3.7.7 (L1) Ensure 'Interactive logon: Prompt user to change password before expiration' is set to 'between 5 and 14 days'

.DESCRIPTION
This policy setting determines how far in advance users are warned that their password will expire.

.EXAMPLE
Test-InteractiveLogonPasswordExpiryWarning

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.7.7   (L1) Ensure 'Interactive logon: Prompt user to change password before expiration' is set to 'bet... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-InteractiveLogonPasswordExpiryWarning {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\PasswordExpiryWarning"
        $RecommendationNumber = '2.3.7.7'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Interactive logon: Prompt user to change password before expiration' is set to 'between 5 and 14 days'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Setting = [int]$Entry.SettingNumber
        if (($Setting -ge 5) -and ($Setting -le 14)) {
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
2.3.7.8 (L1) Ensure 'Interactive logon: Require Domain Controller Authentication to unlock workstation' is set to 'Enabled' (MS Only)

.DESCRIPTION
Logon information is required to unlock a locked computer. For domain accounts, this security setting determines whether it is necessary to contact a Domain Controller to unlock a computer.

.EXAMPLE
Test-InteractiveLogonForceUnlockLogon

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.7.8   (L1) Ensure 'Interactive logon: Require Domain Controller Authentication to unlock workstation' ... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-InteractiveLogonForceUnlockLogon {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\ForceUnlockLogon"
        $RecommendationNumber = '2.3.7.8'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Interactive logon: Require Domain Controller Authentication to unlock workstation' is set to 'Enabled' (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.KeyName) {
            $Pass = $Setting
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
2.3.7.9 (L1) Ensure 'Interactive logon: Smart card removal behavior' is set to 'Lock Workstation' or higher

.DESCRIPTION
This policy setting determines what happens when the smart card for a logged-on user is removed from the smart card reader.

.EXAMPLE
Test-InteractiveLogonScRemoveOption

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.7.9   (L1) Ensure 'Interactive logon: Smart card removal behavior' is set to 'Lock Workstation' or higher Group Policy Settings     True    

.NOTES
General notes
#>
function Test-InteractiveLogonScRemoveOption {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\ScRemoveOption"
        $RecommendationNumber = '2.3.7.9'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Interactive logon: Smart card removal behavior' is set to 'Lock Workstation' or higher"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Setting = $Entry.Display.DisplayString
        if ([int]$Entry.SettingString -ge 1) {
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

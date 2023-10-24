<#
.SYNOPSIS
2.3.17.1 (L1) Ensure 'User Account Control: Admin Approval Mode for the Built-in Administrator account' is set to 'Enabled'

.DESCRIPTION
This policy setting controls the behavior of Admin Approval Mode for the built-in Administrator account.

.EXAMPLE
Test-UserAccountControlFilterAdministratorToken

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.17.1  (L1) Ensure 'User Account Control: Admin Approval Mode for the Built-in Administrator account' i... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-UserAccountControlFilterAdministratorToken {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\FilterAdministratorToken"
        $RecommendationNumber = '2.3.17.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'User Account Control: Admin Approval Mode for the Built-in Administrator account' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
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
2.3.17.2 (L1) Ensure 'User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode' is set to 'Prompt for consent on the secure desktop' or higher

.DESCRIPTION
This policy setting controls the behavior of the elevation prompt for administrators.

.EXAMPLE
Test-UserAccountControlConsentPromptBehaviorAdmin

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.17.2  (L1) Ensure 'User Account Control: Behavior of the elevation prompt for administrators in Admin ... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-UserAccountControlConsentPromptBehaviorAdmin {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorAdmin"
        $RecommendationNumber = '2.3.17.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode' is set to 'Prompt for consent on the secure desktop' or higher"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        $Setting = $Entry.Display.DisplayString
        if ([int]$Entry.SettingNumber -ge 2) {
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
2.3.17.3 (L1) Ensure 'User Account Control: Behavior of the elevation prompt for standard users' is set to 'Automatically deny elevation requests'

.DESCRIPTION
This policy setting controls the behavior of the elevation prompt for standard users.

.EXAMPLE
Test-UserAccountControlConsentPromptBehaviorUser

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.17.3  (L1) Ensure 'User Account Control: Behavior of the elevation prompt for standard users' is set t... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-UserAccountControlConsentPromptBehaviorUser {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorUser"
        $RecommendationNumber = '2.3.17.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'User Account Control: Behavior of the elevation prompt for standard users' is set to 'Automatically deny elevation requests'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        $Setting = $Entry.Display.DisplayString
        if ($Entry.KeyName) {
            if ($Entry.SettingNumber -eq 0) {
                $Pass = $true
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
2.3.17.4 (L1) Ensure 'User Account Control: Detect application installations and prompt for elevation' is set to 'Enabled'

.DESCRIPTION
This policy setting controls the behavior of application installation detection for the computer.

.EXAMPLE
Test-UserAccountControlEnableInstallerDetection

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.17.4  (L1) Ensure 'User Account Control: Detect application installations and prompt for elevation' is... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-UserAccountControlEnableInstallerDetection {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableInstallerDetection"
        $RecommendationNumber = '2.3.17.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'User Account Control: Detect application installations and prompt for elevation' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
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
2.3.17.5 (L1) Ensure 'User Account Control: Only elevate UIAccess applications that are installed in secure locations' is set to 'Enabled'

.DESCRIPTION
This policy setting controls whether applications that request to run with a User Interface Accessibility (UIAccess) integrity level must reside in a secure location in the file system.

.EXAMPLE
Test-UserAccountControlEnableSecureUIAPaths

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.17.5  (L1) Ensure 'User Account Control: Only elevate UIAccess applications that are installed in secu... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-UserAccountControlEnableSecureUIAPaths {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableSecureUIAPaths"
        $RecommendationNumber = '2.3.17.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'User Account Control: Only elevate UIAccess applications that are installed in secure locations' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
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
2.3.17.6 (L1) Ensure 'User Account Control: Run all administrators in Admin Approval Mode' is set to 'Enabled'

.DESCRIPTION
This policy setting controls the behavior of all User Account Control (UAC) policy settings for the computer.

.EXAMPLE
Test-UserAccountControlEnableLUA

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.17.6  (L1) Ensure 'User Account Control: Run all administrators in Admin Approval Mode' is set to 'Ena... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-UserAccountControlEnableLUA {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA"
        $RecommendationNumber = '2.3.17.6'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'User Account Control: Run all administrators in Admin Approval Mode' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
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
2.3.17.7 (L1) Ensure 'User Account Control: Switch to the secure desktop when prompting for elevation' is set to 'Enabled'

.DESCRIPTION
This policy setting controls whether the elevation request prompt is displayed on the interactive user's desktop or the secure desktop.

.EXAMPLE
Test-UserAccountControlPromptOnSecureDesktop

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.17.7  (L1) Ensure 'User Account Control: Switch to the secure desktop when prompting for elevation' is... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-UserAccountControlPromptOnSecureDesktop {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\PromptOnSecureDesktop"
        $RecommendationNumber = '2.3.17.7'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'User Account Control: Switch to the secure desktop when prompting for elevation' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
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
2.3.17.8 (L1) Ensure 'User Account Control: Virtualize file and registry write failures to per-user locations' is set to 'Enabled'

.DESCRIPTION
This policy setting controls whether application write failures are redirected to defined registry and file system locations.

.EXAMPLE
Test-UserAccountControlEnableVirtualization

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.17.8  (L1) Ensure 'User Account Control: Virtualize file and registry write failures to per-user locat... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-UserAccountControlEnableVirtualization {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableVirtualization"
        $RecommendationNumber = '2.3.17.8'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'User Account Control: Virtualize file and registry write failures to per-user locations' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
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

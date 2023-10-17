function Test-AccountsNoConnectedUser {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $RecommendationNumber = '2.3.1.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\NoConnectedUser"
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Entry.SettingNumber -eq 3) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Entry.Display.DisplayString
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-AccountsEnableGuestAccount {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "EnableGuestAccount"
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "SystemAccessPolicyName"
        [bool]$Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Setting) {
            $Pass = $false
        } elseif ($setting -eq $false) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $RecommendationNumber = '2.3.1.2'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only)"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
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

function Test-AccountsLimitBlankPasswordUse {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\LimitBlankPasswordUse"
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
    }

    process {
        [bool]$Pass = [int]$Entry.SettingNumber
    }

    end {
        $RecommendationNumber = '2.3.1.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled'"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Entry.Display.DisplayString
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-AccountsNewAdministratorName {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "NewAdministratorName"
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "SystemAccessPolicyName"
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if (($Entry) -and ($Entry.SettingString -ne "Administrator")) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $RecommendationNumber = '2.3.1.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Configure 'Accounts: Rename administrator account'"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Entry.SettingString
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-AccountsNewGuestName {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "NewGuestName"
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "SystemAccessPolicyName"
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if (($Entry) -and ($Entry.SettingString -ne "Guest")) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $RecommendationNumber = '2.3.1.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Configure 'Accounts: Rename guest account'"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Entry.SettingString
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

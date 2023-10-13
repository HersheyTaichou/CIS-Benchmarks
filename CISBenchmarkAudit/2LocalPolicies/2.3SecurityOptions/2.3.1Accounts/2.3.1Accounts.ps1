function Test-AccountsNoConnectedUser {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\NoConnectedUser"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Entry.SettingNumber -eq 3) {
            $result = $true
        } else {
            $result = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.1.1'
            'ProfileApplicability' = @("Level 1 - Domain Controller","Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'"
            'Source' = 'Group Policy Settings'
            'Result'= $Result
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
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "SystemAccessPolicyName"
        [bool]$Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Setting) {
            $result = $false
        } elseif ($setting -eq $false) {
            $result = $true
        } else {
            $result = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.1.2'
            'ProfileApplicability' = @("Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only)"
            'Source' = 'Group Policy Settings'
            'Result'= $Result
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
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        [bool]$result = [int]$Entry.SettingNumber
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.1.3'
            'ProfileApplicability' = @("Level 1 - Domain Controller","Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled'"
            'Source' = 'Group Policy Settings'
            'Result'= $Result
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
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "SystemAccessPolicyName"
        [string]$Setting = $Entry.SettingString
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Setting -ne "Administrator") {
            $result = $true
        } else {
            $result = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.1.4'
            'ProfileApplicability' = @("Level 1 - Domain Controller","Level 1 - Member Server")
            'RecommendationName'= "Configure 'Accounts: Rename administrator account'"
            'Source' = 'Group Policy Settings'
            'Result'= $Result
            'Setting' = $Setting
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
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "SystemAccessPolicyName"
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Entry.SettingString -ne "Guest") {
            $result = $true
        } else {
            $result = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.1.5'
            'ProfileApplicability' = @("Level 1 - Domain Controller","Level 1 - Member Server")
            'RecommendationName'= "Configure 'Accounts: Rename guest account'"
            'Source' = 'Group Policy Settings'
            'Result'= $Result
            'Setting' = $Entry.SettingString
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-AccountsNoConnectedUser {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\NoConnectedUser"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.KeyName -eq $EntryName) {
                    $Setting = $Entry.SettingNumber
                    $DisplayString = $Entry.Display.DisplayString
                    $RawEntry = $Entry
                }
            }
        }
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Setting -eq 3) {
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
            'Setting' = $DisplayString
            'Entry' = $RawEntry
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

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "EnableGuestAccount"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.SystemAccessPolicyName -eq $EntryName) {
                    [bool]$Setting = $Entry.SettingNumber
                    $RawEntry = $Entry
                }
            }
        }
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Setting -eq $false) {
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
            'Entry' = $RawEntry
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

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\LimitBlankPasswordUse"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.SystemAccessPolicyName -eq $EntryName) {
                    [bool]$Setting = $Entry.SettingNumber
                    $DisplayString = $Entry.Display.DisplayString
                    $RawEntry = $Entry
                }
            }
        }
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Setting -eq $true) {
            $result = $true
        } else {
            $result = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.1.3'
            'ProfileApplicability' = @("Level 1 - Domain Controller","Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled'"
            'Source' = 'Group Policy Settings'
            'Result'= $Result
            'Setting' = $DisplayString
            'Entry' = $RawEntry
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

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "NewAdministratorName"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.SystemAccessPolicyName -eq $EntryName) {
                    [string]$Setting = $Entry.SettingString
                    $RawEntry = $Entry
                }
            }
        }
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
            'Entry' = $RawEntry
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

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "NewGuestName"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.SystemAccessPolicyName -eq $EntryName) {
                    [string]$Setting = $Entry.SettingString
                    $RawEntry = $Entry
                }
            }
        }
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Setting -ne "Guest") {
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
            'Setting' = $Setting
            'Entry' = $RawEntry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

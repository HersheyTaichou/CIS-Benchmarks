function Test-DomainMemberRequireSignOrSeal {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RequireSignOrSeal"
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
    }

    process {
        [bool]$Pass = [int]$Entry.SettingNumber
    }

    end {
        $RecommendationNumber = '2.3.6.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Domain member: Digitally encrypt or sign secure channel data (always)' is set to 'Enabled'"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = [int]$Entry.SettingNumber
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-DomainMemberSealSecureChannel {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\SealSecureChannel"
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
    }

    process {
        [bool]$Pass = [int]$Entry.SettingNumber
    }

    end {
        $RecommendationNumber = '2.3.6.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Domain member: Digitally encrypt secure channel data (when possible)' is set to 'Enabled'"
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

function Test-DomainMemberSignSecureChannel {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\SignSecureChannel"
        $RecommendationNumber = '2.3.6.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Domain member: Digitally sign secure channel data (when possible)' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
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

function Test-DomainMemberDisablePasswordChange {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\DisablePasswordChange"
        $RecommendationNumber = '2.3.6.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Domain member: Disable machine account password changes' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Setting) {
            $Pass = $false
        } elseif ($setting -eq $false) {
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
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-DomainMemberMaximumPasswordAge {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\MaximumPasswordAge"
        $RecommendationNumber = '2.3.6.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Domain member: Maximum machine account password age' is set to '30 or fewer days, but not 0'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
    }

    process {
        $Setting = [int]$Entry.SettingNumber
        if (($Setting -le 30) -and ($Setting -gt 0)) {
            $Pass = $true
        }
    }

    end {
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

function Test-DomainMemberRequireStrongKey {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RequireStrongKey"
        $RecommendationNumber = '2.3.6.6'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Domain member: Require strong (Windows 2000 or later) session key' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
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

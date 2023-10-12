function Test-DomainMemberRequireSignOrSeal {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RequireSignOrSeal"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        [bool]$result = [int]$Entry.SettingNumber
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.6.1'
            'ProfileApplicability' = @("Level 1 - Domain Controller","Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Domain member: Digitally encrypt or sign secure channel data (always)' is set to 'Enabled'"
            'Source' = 'Group Policy Settings'
            'Result'= $result
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
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        [bool]$result = [int]$Entry.SettingNumber
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.6.2'
            'ProfileApplicability' = @("Level 1 - Domain Controller","Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Domain member: Digitally encrypt secure channel data (when possible)' is set to 'Enabled'"
            'Source' = 'Group Policy Settings'
            'Result'= $result
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
        $RecommendationName = "Ensure 'Domain member: Digitally sign secure channel data (when possible)' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        $result = $Setting
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
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
        $RecommendationName = "Ensure 'Domain member: Disable machine account password changes' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        $result = -not($Setting)
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
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
        $RecommendationName = "Ensure 'Domain member: Maximum machine account password age' is set to '30 or fewer days, but not 0'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        $Setting = [int]$Entry.SettingNumber
        if (($Setting -le 30) -and ($Setting -gt 0)) {
            $result = $true
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
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
        $EntryName = ""
        $RecommendationNumber = '2.3.6.6'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RequireStrongKey"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        $result = $Setting
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-DomainControllerSubmitControl {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\SubmitControl"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.KeyName -eq $EntryName) {
                    [bool]$Setting = [int]$Entry.SettingNumber
                    $RawEntry = $Entry
                }
            }
        }
    }

    process {
        if (-not($Setting)) {
            $result = $true
        } else {
            $result = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.5.1'
            'ConfigurationProfile' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Domain controller: Allow server operators to schedule tasks' is set to 'Disabled' (DC only)"
            'Source' = 'Group Policy Settings'
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $RawEntry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-DomainControllerVulnerableChannelAllowList {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\VulnerableChannelAllowList"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.KeyName -eq $EntryName) {
                    [string]$Setting = $Entry.SettingString
                    $RawEntry = $Entry
                }
            }
        }
    }

    process {
        if ($Setting) {
            $result = $false
        } else {
            $result = $true
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.5.2'
            'ConfigurationProfile' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Domain controller: Allow vulnerable Netlogon secure channel connections' is set to 'Not Configured'"
            'Source' = 'Group Policy Settings'
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $RawEntry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-DomainControllerLdapEnforceChannelBinding {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\LdapEnforceChannelBinding"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.KeyName -eq $EntryName) {
                    [string]$Setting = $Entry.Display.DisplayString
                    $RawEntry = $Entry
                }
            }
        }
    }

    process {
        if ($Setting = "Always") {
            $result = $true
        } else {
            $result = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.5.3'
            'ConfigurationProfile' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Domain controller: LDAP server channel binding token requirements' is set to 'Always'"
            'Source' = 'Group Policy Settings'
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $RawEntry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-DomainControllerLDAPServerIntegrity {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\LDAPServerIntegrity"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.KeyName -eq $EntryName) {
                    [string]$Setting = $Entry.Display.DisplayString
                    $RawEntry = $Entry
                }
            }
        }
    }

    process {
        if ($Setting = "Require signing") {
            $result = $true
        } else {
            $result = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.5.4'
            'ConfigurationProfile' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Domain controller: LDAP server signing requirements' is set to 'Require signing' (DC only)"
            'Source' = 'Group Policy Settings'
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $RawEntry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-DomainControllerRefusePasswordChange {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RefusePasswordChange"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.KeyName -eq $EntryName) {
                    [bool]$Setting = [int]$Entry.SettingNumber
                    $RawEntry = $Entry
                }
            }
        }
    }

    process {
        if (-not($Setting)) {
            Write-Verbose "2.3.5.5 is False"
            $result = $true
        } else {
            Write-Verbose "2.3.5.5 is not False"
            $result = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.5.5'
            'ConfigurationProfile' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Domain controller: Refuse machine account password changes' is set to 'Disabled' (DC only)"
            'Source' = 'Group Policy Settings'
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $RawEntry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

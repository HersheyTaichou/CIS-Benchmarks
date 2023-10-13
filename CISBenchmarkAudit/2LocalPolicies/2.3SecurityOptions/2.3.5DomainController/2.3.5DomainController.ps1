function Test-DomainControllerSubmitControl {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\SubmitControl"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName $KeyName
        [bool]$Setting = [int]$Entry.SettingNumber
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
            'ProfileApplicability' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Domain controller: Allow server operators to schedule tasks' is set to 'Disabled' (DC only)"
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

function Test-DomainControllerVulnerableChannelAllowList {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\VulnerableChannelAllowList"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName $KeyName
        [string]$Setting = $Entry.SettingString
        
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
            'ProfileApplicability' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Domain controller: Allow vulnerable Netlogon secure channel connections' is set to 'Not Configured'"
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

function Test-DomainControllerLdapEnforceChannelBinding {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        $EntryName = "MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\LdapEnforceChannelBinding"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName $KeyName
        [string]$Setting = $Entry.Display.DisplayString
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
            'ProfileApplicability' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Domain controller: LDAP server channel binding token requirements' is set to 'Always'"
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

function Test-DomainControllerLDAPServerIntegrity {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\LDAPServerIntegrity"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName $KeyName
        [string]$Setting = $Entry.Display.DisplayString
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
            'ProfileApplicability' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Domain controller: LDAP server signing requirements' is set to 'Require signing' (DC only)"
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

function Test-DomainControllerRefusePasswordChange {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RefusePasswordChange"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName $KeyName
        [bool]$Setting = [int]$Entry.SettingNumber
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
            'RecommendationNumber'= '2.3.5.5'
            'ProfileApplicability' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Domain controller: Refuse machine account password changes' is set to 'Disabled' (DC only)"
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

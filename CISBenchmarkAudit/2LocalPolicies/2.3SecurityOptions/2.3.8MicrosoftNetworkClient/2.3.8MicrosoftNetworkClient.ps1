function Test-MicrosoftNetworkClientRequireSecuritySignature {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\RequireSecuritySignature"
        $RecommendationNumber = '2.3.8.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Microsoft network client: Digitally sign communications (always)' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Setting) {
            $result = $Setting
        } else {
            $result = $false
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

function Test-MicrosoftNetworkClientEnableSecuritySignature {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\EnableSecuritySignature"
        $RecommendationNumber = '2.3.8.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Microsoft network client: Digitally sign communications (if server agrees)' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Setting) {
            $result = $Setting
        } else {
            $result = $false
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

function Test-MicrosoftNetworkClientEnablePlainTextPassword {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\EnablePlainTextPassword"
        $RecommendationNumber = '2.3.8.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Microsoft network client: Send unencrypted password to third-party SMB servers' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
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

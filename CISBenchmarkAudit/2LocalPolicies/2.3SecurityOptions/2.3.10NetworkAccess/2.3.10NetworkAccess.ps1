function Test-NetworkAccessLSAAnonymousNameLookup {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "LSAAnonymousNameLookup"
        $RecommendationNumber = '2.3.10.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = ""
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "SystemAccessPolicyName"
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

function Test-NetworkAccessRestrictAnonymousSAM {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymousSAM"
        $RecommendationNumber = '2.3.10.2'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts' is set to 'Enabled' (MS only)"
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

function Test-NetworkAccessRestrictAnonymous {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymous"
        $RecommendationNumber = '2.3.10.3'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts and shares' is set to 'Enabled' (MS only)"
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

function Test-NetworkAccessDisableDomainCreds {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\DisableDomainCreds"
        $RecommendationNumber = '2.3.10.4'
        $ProfileApplicability = @("Level 2 - Domain Controller","Level 2 - Member Server")
        $RecommendationName = "Ensure 'Network access: Do not allow storage of passwords and credentials for network authentication' is set to 'Enabled'"
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

function Test-NetworkAccessEveryoneIncludesAnonymous {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\EveryoneIncludesAnonymous"
        $RecommendationNumber = '2.3.10.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disabled'"
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

# 2.3.10.6 and 2.3.10.7
function Test-NetworkAccessNullSessionPipes {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $ServerType = Get-ProductType
        $Source = 'Group Policy Settings'
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionPipes"
        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        [array]$Setting = $Entry.SettingStrings.Value
        $DomainController = @("LSARPC","NETLOGON","SAMR")
        $DCBrowser = @("LSARPC", "NETLOGON", "SAMR","BROWSER")
        $MemberServer = @()
        $MSBrowser = @("BROWSER")
        $MSRDS = @("HydraLSPipe","TermServLicensing")
        $MSRDSBrowser = @("HydraLSPipe","TermServLicensing","BROWSER")

        if ($ServerType -eq 2) {
            $RecommendationNumber = '2.3.10.6'
            $ProfileApplicability = @("Level 1 - Domain Controller")
            $RecommendationName = "Configure 'Network access: Named Pipes that can be accessed anonymously' (DC only)"
            if (-not(Compare-Object -ReferenceObject $DomainController -DifferenceObject $setting)) {
                $result = $true
            } elseif (-not(Compare-Object -ReferenceObject $DCBrowser -DifferenceObject $setting)) {
                $result = $true
            } else {
                $result = $false
            }
        } elseif ($ServerType -eq 3) {
            $RecommendationNumber = '2.3.10.7'
            $ProfileApplicability = @("Level 1 - Member Server")
            $RecommendationName = "Configure 'Network access: Named Pipes that can be accessed anonymously' (MS only)"
            if (-not(Compare-Object -ReferenceObject $MemberServer -DifferenceObject $setting)) {
                $result = $true
            } elseif (-not(Compare-Object -ReferenceObject $MSBrowser -DifferenceObject $setting)) {
                $result = $true
            } elseif (-not(Compare-Object -ReferenceObject $MSRDS -DifferenceObject $setting)) {
                $result = $true
            } elseif (-not(Compare-Object -ReferenceObject $MSRDSBrowser -DifferenceObject $setting)) {
                $result = $true
            } else {
                $result = $false
            }
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

function Test-NetworkAccessAllowedExactPaths {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedExactPaths\Machine"
        $RecommendationNumber = '2.3.10.8'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Configure 'Network access: Remotely accessible registry paths' is configured"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        $Setting = $Entry.SettingStrings.Value
        $Definition = @('System\CurrentControlSet\Control\ProductOptions','System\CurrentControlSet\Control\Server Applications','Software\Microsoft\Windows NT\CurrentVersion')
        if (-not(Compare-Object -ReferenceObject $Definition -DifferenceObject $setting)) {
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

function Test-NetworkAccessAllowedPaths {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedPaths\Machine"
        $RecommendationNumber = '2.3.10.9'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Configure 'Network access: Remotely accessible registry paths and sub-paths' is configured"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        $Setting = $Entry.SettingStrings.Value
        $definition = @('System\CurrentControlSet\Control\Print\Printers','System\CurrentControlSet\Services\Eventlog','Software\Microsoft\OLAP Server','Software\Microsoft\Windows NT\CurrentVersion\Print','Software\Microsoft\Windows NT\CurrentVersion\Windows','System\CurrentControlSet\Control\ContentIndex','System\CurrentControlSet\Control\Terminal Server','System\CurrentControlSet\Control\Terminal Server\UserConfig','System\CurrentControlSet\Control\Terminal Server\DefaultUserConfiguration','Software\Microsoft\Windows NT\CurrentVersion\Perflib','System\CurrentControlSet\Services\SysmonLog')
        $ADCS = $definition + 'System\CurrentControlSet\Services\CertSvc'
        $WINS = $definition + 'System\CurrentControlSet\Services\WINS'
        $ADCSWins = $ADCS + 'System\CurrentControlSet\Services\WINS'

        if (-not(Compare-Object -ReferenceObject $definition -DifferenceObject $setting)) {
            $result = $true
        } elseif (-not(Compare-Object -ReferenceObject $ADCS -DifferenceObject $setting)) {
            $result = $true
        } elseif (-not(Compare-Object -ReferenceObject $WINS -DifferenceObject $setting)) {
            $result = $true
        } elseif (-not(Compare-Object -ReferenceObject $ADCSWins -DifferenceObject $setting)) {
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

function Test-NetworkAccessRestrictNullSessAccess {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\RestrictNullSessAccess"
        $RecommendationNumber = '2.3.10.10'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Network access: Restrict anonymous access to Named Pipes and Shares' is set to 'Enabled'"
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

function Test-NetworkAccessRestrictRemoteSAM {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\RestrictRemoteSAM"
        $RecommendationNumber = '2.3.10.11'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "Ensure 'Network access: Restrict clients allowed to make remote calls to SAM' is set to 'Administrators: Remote Access: Allow' (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        $Setting = $Entry.SettingString
        $Definition = "O:BAG:BAD:(A;;RC;;;BA)"
        if ($Setting -eq $Definition) {
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

function Test-NetworkAccessNullSessionShares {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionShares"
        $RecommendationNumber = '2.3.10.12'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Network access: Shares that can be accessed anonymously' is set to 'None'$cisb"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        $setting = $Entry.SettingStrings.Value
        if ($Entry.KeyName) {
            if (-not($setting)) {
                $result = $true
            } else {
                $result = $false
            }
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

function Test-NetworkAccessForceGuest {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\ForceGuest"
        $RecommendationNumber = '2.3.10.13'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Network access: Sharing and security model for local accounts' is set to 'Classic - local users authenticate as themselves'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
    }

    process {
        $Setting = [int]$Entry.SettingNumber
        if ($Setting -eq 0) {
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

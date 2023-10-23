function Test-DomainProfileEnableFirewall {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "DomainProfile"
        $RecommendationNumber = '9.1.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On (recommended)'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Entry.EnableFirewall.Value -eq "true") {
            $Setting = $true
        } else {
            $Setting = $false
        }
        $Pass = $Setting
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

function Test-DomainProfileDefaultInboundAction {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "DomainProfile"
        $RecommendationNumber = '9.1.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'Block (default)'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Entry.DefaultInboundAction.Value -eq "true") {
            $Setting = $true
        } else {
            $Setting = $false
        }
        $Pass = $Setting
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

function Test-DomainProfileDefaultOutboundAction {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "DomainProfile"
        $RecommendationNumber = '9.1.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Domain: Outbound connections' is set to 'Allow (default)'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Entry.DefaultOutboundAction.Value -eq "false") {
            $Setting = $false
        } else {
            $Setting = $true
        }
        $Pass = -not($Setting)
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

function Test-DomainProfileDisableNotifications {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "DomainProfile"
        $RecommendationNumber = '9.1.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Domain: Settings: Display a notification' is set to 'No'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Entry.DisableNotifications.Value -eq "true") {
            $Setting = $true
        } else {
            $Setting = $false
        }
        $Pass = $Setting
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

function Test-DomainProfileLogFilePath {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "DomainProfile"
        $RecommendationNumber = '9.1.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Domain: Logging: Name' is set to '%SystemRoot%\System32\logfiles\firewall\domainfw.log'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        $Setting = $Entry.LogFilePath.Value
        if ($Setting -eq "%systemroot%\system32\logfiles\firewall\domainfw.log") {
            $Pass = $true
        } elseif ($Setting -ne "%systemroot%\system32\logfiles\firewall\pfirewall.log") {
            $Pass = $true
            $Message = $EntryName + " Log File Path is not the default, but is also not the recommended value. To pass, each profile should have a different log file."
            Write-Verbose $Message
        }else {
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

function Test-DomainProfileLogFileSize {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "DomainProfile"
        $RecommendationNumber = '9.1.6'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Domain: Logging: Size limit (KB)' is set to '16,384 KB or greater'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        $Setting = [int]$Entry.LogFileSize.Value
        if ($Setting -ge 16384) {
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

function Test-DomainProfileLogDroppedPackets {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "DomainProfile"
        $RecommendationNumber = '9.1.7'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Domain: Logging: Log dropped packets' is set to 'Yes'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Entry.LogDroppedPackets.Value -eq "true") {
            $Setting = $true
        } else {
            $Setting = $false
        }
        $Pass = $Setting
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

function Test-DomainProfileLogSuccessfulConnections {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "DomainProfile"
        $RecommendationNumber = '9.1.8'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Domain: Logging: Log successful connections' is set to 'Yes'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Entry.LogSuccessfulConnections.Value -eq "true") {
            $Setting = $true
        } else {
            $Setting = $false
        }
        $Pass = $Setting
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

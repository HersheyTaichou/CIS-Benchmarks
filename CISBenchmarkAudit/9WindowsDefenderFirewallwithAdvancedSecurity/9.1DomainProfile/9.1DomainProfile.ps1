<#
.SYNOPSIS
9.1.1 (L1) Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On (recommended)'

.DESCRIPTION
Select On (recommended) to have Windows Firewall with Advanced Security use the settings for this profile to filter network traffic.

.EXAMPLE
Test-DomainProfileEnableFirewall

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.1.1      (L1) Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On (re... Group Policy Settings     True  

.NOTES
General notes
#>
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

<#
.SYNOPSIS
9.1.2 (L1) Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'Block (default)'

.DESCRIPTION
This setting determines the behavior for inbound connections that do not match an inbound firewall rule.

.EXAMPLE
Test-DomainProfileDefaultInboundAction

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.1.2      (L1) Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'B... Group Policy Settings     True  

.NOTES
General notes
#>
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

<#
.SYNOPSIS
9.1.3 (L1) Ensure 'Windows Firewall: Domain: Outbound connections' is set to 'Allow (default)'

.DESCRIPTION
This setting determines the behavior for outbound connections that do not match an outbound firewall rule.

.EXAMPLE
Test-DomainProfileDefaultOutboundAction

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.1.3      (L1) Ensure 'Windows Firewall: Domain: Outbound connections' is set to '... Group Policy Settings     True  

.NOTES
General notes
#>
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

<#
.SYNOPSIS
9.1.4 (L1) Ensure 'Windows Firewall: Domain: Settings: Display a notification' is set to 'No'

.DESCRIPTION
Select this option to have Windows Firewall with Advanced Security display notifications to the user when a program is blocked from receiving inbound connections.

.EXAMPLE
Test-DomainProfileDisableNotifications

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.1.4      (L1) Ensure 'Windows Firewall: Domain: Settings: Display a notification'... Group Policy Settings     True  

.NOTES
General notes
#>
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

<#
.SYNOPSIS
9.1.5 (L1) Ensure 'Windows Firewall: Domain: Logging: Name' is set to '%SystemRoot%\System32\logfiles\firewall\domainfw.log'

.DESCRIPTION
Use this option to specify the path and name of the file in which Windows Firewall will write its log information.

.EXAMPLE
Test-DomainProfileLogFilePath

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.1.5      (L1) Ensure 'Windows Firewall: Domain: Logging: Name' is set to '%System... Group Policy Settings     True  

.NOTES
General notes
#>
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

<#
.SYNOPSIS
9.1.6 (L1) Ensure 'Windows Firewall: Domain: Logging: Size limit (KB)' is set to '16,384 KB or greater'

.DESCRIPTION
Use this option to specify the size limit of the file in which Windows Firewall will write its log information.

.EXAMPLE
Test-DomainProfileLogFileSize

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.1.6      (L1) Ensure 'Windows Firewall: Domain: Logging: Size limit (KB)' is set ... Group Policy Settings     True  

.NOTES
General notes
#>
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

<#
.SYNOPSIS
9.1.7 (L1) Ensure 'Windows Firewall: Domain: Logging: Log dropped packets' is set to 'Yes'

.DESCRIPTION
Use this option to log when Windows Firewall with Advanced Security discards an inbound packet for any reason. The log records why and when the packet was dropped.

.EXAMPLE
Test-DomainProfileLogDroppedPackets

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.1.7      (L1) Ensure 'Windows Firewall: Domain: Logging: Log dropped packets' is ... Group Policy Settings     True  

.NOTES
General notes
#>
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

<#
.SYNOPSIS
9.1.8 (L1) Ensure 'Windows Firewall: Domain: Logging: Log successful connections' is set to 'Yes' (

.DESCRIPTION
Use this option to log when Windows Firewall with Advanced Security allows an inbound connection. The log records why and when the connection was formed.

.EXAMPLE
Test-DomainProfileLogSuccessfulConnections

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.1.8      (L1) Ensure 'Windows Firewall: Domain: Logging: Log successful connectio... Group Policy Settings     True  

.NOTES
General notes
#>
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

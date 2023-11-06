<#
.SYNOPSIS
9.3.1 (L1) Ensure 'Windows Firewall: Public: Firewall state' is set to 'On (recommended)'

.DESCRIPTION
Select On (recommended) to have Windows Firewall with Advanced Security use the settings for this profile to filter network traffic.

.EXAMPLE
Test-PublicProfileEnableFirewall

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.3.1      (L1) Ensure 'Windows Firewall: Public: Firewall state' is set to 'On (re... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PublicProfileEnableFirewall {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "PublicProfile"
        $RecommendationNumber = '9.3.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Public: Firewall state' is set to 'On (recommended)'"
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
9.3.2 (L1) Ensure 'Windows Firewall: Public: Inbound connections' is set to 'Block (default)'

.DESCRIPTION
This setting determines the behavior for inbound connections that do not match an inbound firewall rule.

.EXAMPLE
Test-PublicProfileDefaultInboundAction

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.3.2      (L1) Ensure 'Windows Firewall: Public: Inbound connections' is set to 'B... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PublicProfileDefaultInboundAction {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "PublicProfile"
        $RecommendationNumber = '9.3.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Public: Inbound connections' is set to 'Block (default)'"
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
9.3.3 (L1) Ensure 'Windows Firewall: Public: Outbound connections' is set to 'Allow (default)'

.DESCRIPTION
This setting determines the behavior for outbound connections that do not match an outbound firewall rule.

.EXAMPLE
Test-PublicProfileDefaultOutboundAction

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.3.3      (L1) Ensure 'Windows Firewall: Public: Outbound connections' is set to '... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PublicProfileDefaultOutboundAction {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "PublicProfile"
        $RecommendationNumber = '9.3.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Public: Outbound connections' is set to 'Allow (default)'"
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
9.3.4 (L1) Ensure 'Windows Firewall: Public: Settings: Display a notification' is set to 'No'

.DESCRIPTION
Select this option to have Windows Firewall with Advanced Security display notifications to the user when a program is blocked from receiving inbound connections.

.EXAMPLE
Test-PublicProfileDisableNotifications

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.3.4      (L1) Ensure 'Windows Firewall: Public: Settings: Display a notification'... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PublicProfileDisableNotifications {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "PublicProfile"
        $RecommendationNumber = '9.3.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Public: Settings: Display a notification' is set to 'No'"
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
9.3.5 (L1) Ensure 'Windows Firewall: Public: Settings: Apply local firewall rules' is set to 'No'

.DESCRIPTION
This setting controls whether local administrators are allowed to create local firewall rules that apply together with firewall rules configured by Group Policy.

.EXAMPLE
Test-PublicProfileAllowLocalPolicyMerge

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.3.5      (L1) Ensure 'Windows Firewall: Public: Settings: Apply local firewall ru... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PublicProfileAllowLocalPolicyMerge {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "PublicProfile"
        $RecommendationNumber = '9.3.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Public: Settings: Apply local firewall rules' is set to 'No'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Entry.AllowLocalPolicyMerge.Value -eq "false") {
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
9.3.6 (L1) Ensure 'Windows Firewall: Public: Settings: Apply local connection security rules' is set to 'No'

.DESCRIPTION
This setting controls whether local administrators are allowed to create connection security rules that apply together with connection security rules configured by Group Policy.

.EXAMPLE
Test-PublicProfileAllowLocalIPsecPolicyMerge

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.3.6      (L1) Ensure 'Windows Firewall: Public: Settings: Apply local connection ... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PublicProfileAllowLocalIPsecPolicyMerge {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "PublicProfile"
        $RecommendationNumber = '9.3.6'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Public: Settings: Apply local connection security rules' is set to 'No'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Entry.AllowLocalIPsecPolicyMerge.Value -eq "false") {
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
9.3.7 (L1) Ensure 'Windows Firewall: Public: Logging: Name' is set to '%SystemRoot%\System32\logfiles\firewall\publicfw.log'

.DESCRIPTION
Use this option to specify the path and name of the file in which Windows Firewall will write its log information.

.EXAMPLE
Test-PublicProfileLogFilePath

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.3.7      (L1) Ensure 'Windows Firewall: Public: Logging: Name' is set to '%System... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PublicProfileLogFilePath {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "PublicProfile"
        $RecommendationNumber = '9.3.7'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Public: Logging: Name' is set to '%SystemRoot%\System32\logfiles\firewall\publicfw.log'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        $Setting = $Entry.LogFilePath.Value
        if ($Setting -eq "%systemroot%\system32\logfiles\firewall\publicfw.log") {
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
9.3.8 (L1) Ensure 'Windows Firewall: Public: Logging: Size limit (KB)' is set to '16,384 KB or greater'

.DESCRIPTION
Use this option to specify the size limit of the file in which Windows Firewall will write its log information.

.EXAMPLE
Test-PublicProfileLogFileSize

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.3.8      (L1) Ensure 'Windows Firewall: Public: Logging: Size limit (KB)' is set ... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PublicProfileLogFileSize {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "PublicProfile"
        $RecommendationNumber = '9.3.8'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Public: Logging: Size limit (KB)' is set to '16,384 KB or greater'"
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
9.3.9 (L1) Ensure 'Windows Firewall: Public: Logging: Log dropped packets' is set to 'Yes'

.DESCRIPTION
Use this option to log when Windows Firewall with Advanced Security discards an inbound packet for any reason. The log records why and when the packet was dropped.

.EXAMPLE
Test-PublicProfileLogDroppedPackets

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.3.9      (L1) Ensure 'Windows Firewall: Public: Logging: Log dropped packets' is ... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PublicProfileLogDroppedPackets {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "PublicProfile"
        $RecommendationNumber = '9.3.9'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Public: Logging: Log dropped packets' is set to 'Yes'"
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
9.3.10 (L1) Ensure 'Windows Firewall: Public: Logging: Log successful connections' is set to 'Yes'

.DESCRIPTION
Use this option to log when Windows Firewall with Advanced Security allows an inbound connection. The log records why and when the connection was formed.

.EXAMPLE
Test-PublicProfileLogSuccessfulConnections

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
9.3.10     (L1) Ensure 'Windows Firewall: Public: Logging: Log successful connectio... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-PublicProfileLogSuccessfulConnections {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "PublicProfile"
        $RecommendationNumber = '9.3.10'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Windows Firewall: Public: Logging: Log successful connections' is set to 'Yes'"
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

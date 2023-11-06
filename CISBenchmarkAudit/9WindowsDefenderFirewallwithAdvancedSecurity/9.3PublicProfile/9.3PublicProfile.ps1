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
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PublicProfile"
        $Result.Number = '9.3.1'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Public: Firewall state' is set to 'On (recommended)'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Result.Entry.EnableFirewall.Value -eq "true") {
            $Result.Setting = $true
        } else {
            $Result.Setting = $false
        }
        $Result.SetCorrectly = $Result.Setting
    }

    end {
        return $Result
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
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PublicProfile"
        $Result.Number = '9.3.2'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Public: Inbound connections' is set to 'Block (default)'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Result.Entry.DefaultInboundAction.Value -eq "true") {
            $Result.Setting = $true
        } else {
            $Result.Setting = $false
        }
        $Result.SetCorrectly = $Result.Setting
    }

    end {
        return $Result
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
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PublicProfile"
        $Result.Number = '9.3.3'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Public: Outbound connections' is set to 'Allow (default)'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Result.Entry.DefaultOutboundAction.Value -eq "false") {
            $Result.Setting = $false
        } else {
            $Result.Setting = $true
        }
        $Result.SetCorrectly = -not($Result.Setting)
    }

    end {
        return $Result
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
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PublicProfile"
        $Result.Number = '9.3.4'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Public: Settings: Display a notification' is set to 'No'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Result.Entry.DisableNotifications.Value -eq "true") {
            $Result.Setting = $true
        } else {
            $Result.Setting = $false
        }
        $Result.SetCorrectly = $Result.Setting
    }

    end {
        return $Result
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
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PublicProfile"
        $Result.Number = '9.3.5'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Public: Settings: Apply local firewall rules' is set to 'No'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Result.Entry.AllowLocalPolicyMerge.Value -eq "false") {
            $Result.Setting = $false
        } else {
            $Result.Setting = $true
        }
        $Result.SetCorrectly = -not($Result.Setting)
    }

    end {
        return $Result
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
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PublicProfile"
        $Result.Number = '9.3.6'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Public: Settings: Apply local connection security rules' is set to 'No'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Result.Entry.AllowLocalIPsecPolicyMerge.Value -eq "false") {
            $Result.Setting = $false
        } else {
            $Result.Setting = $true
        }
        $Result.SetCorrectly = -not($Result.Setting)
    }

    end {
        return $Result
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
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PublicProfile"
        $Result.Number = '9.3.7'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Public: Logging: Name' is set to '%SystemRoot%\System32\logfiles\firewall\publicfw.log'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        $Result.Setting = $Result.Entry.LogFilePath.Value
        if ($Result.Setting -eq "%systemroot%\system32\logfiles\firewall\publicfw.log") {
            $Result.SetCorrectly = $true
        } elseif ($Result.Setting -ne "%systemroot%\system32\logfiles\firewall\pfirewall.log") {
            $Result.SetCorrectly = $true
            $Message = $EntryName + " Log File Path is not the default, but is also not the recommended value. To pass, each profile should have a different log file."
            Write-Verbose $Message
        }else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
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
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PublicProfile"
        $Result.Number = '9.3.8'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Public: Logging: Size limit (KB)' is set to '16,384 KB or greater'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        $Result.Setting = [int]$Result.Entry.LogFileSize.Value
        if ($Result.Setting -ge 16384) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
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
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PublicProfile"
        $Result.Number = '9.3.9'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Public: Logging: Log dropped packets' is set to 'Yes'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Result.Entry.LogDroppedPackets.Value -eq "true") {
            $Result.Setting = $true
        } else {
            $Result.Setting = $false
        }
        $Result.SetCorrectly = $Result.Setting
    }

    end {
        return $Result
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
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PublicProfile"
        $Result.Number = '9.3.10'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Public: Logging: Log successful connections' is set to 'Yes'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName
    }

    process {
        if ($Result.Entry.LogSuccessfulConnections.Value -eq "true") {
            $Result.Setting = $true
        } else {
            $Result.Setting = $false
        }
        $Result.SetCorrectly = $Result.Setting
    }

    end {
        return $Result
    }
}

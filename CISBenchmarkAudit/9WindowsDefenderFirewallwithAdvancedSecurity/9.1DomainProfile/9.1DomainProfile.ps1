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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Result.Number = '9.1.1'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On (recommended)'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult -Verbose
        #Write-Verbose $Entry
        $Result.Entry = $Entry
    }

    process {
        $Value = $Result.Entry.EnableFirewall.Value
        if ($Value -eq "true") {
            $Result.Setting = $true
        } else {
            $Result.Setting = $false
        }
        $Result.SetCorrectly = $Result.Setting
    }

    end {
        Return $Result
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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Result.Number = '9.1.2'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'Block (default)'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
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
        Return $Result
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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Result.Number = '9.1.3'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Domain: Outbound connections' is set to 'Allow (default)'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
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
        Return $Result
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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Result.Number = '9.1.4'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Domain: Settings: Display a notification' is set to 'No'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
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
        Return $Result
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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Result.Number = '9.1.5'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Domain: Logging: Name' is set to '%SystemRoot%\System32\logfiles\firewall\domainfw.log'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = $Result.Entry.LogFilePath.Value
        if ($Result.Setting -eq "%systemroot%\system32\logfiles\firewall\domainfw.log") {
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
        Return $Result
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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Result.Number = '9.1.6'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Domain: Logging: Size limit (KB)' is set to '16,384 KB or greater'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
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
        Return $Result
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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Result.Number = '9.1.7'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Domain: Logging: Log dropped packets' is set to 'Yes'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
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
        Return $Result
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
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Result.Number = '9.1.8'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Domain: Logging: Log successful connections' is set to 'Yes'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
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
        Return $Result
    }
}

<#
.SYNOPSIS
9.2.1 (L1) Ensure 'Windows Firewall: Private: Firewall state' is set to 'On (recommended)'

.DESCRIPTION
Select On (recommended) to have Windows Firewall with Advanced Security use the settings for this profile to filter network traffic.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PrivateProfileEnableFirewall

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.2.1      L1    Ensure 'Windows Firewall: Private: Firewall state' is set to... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-PrivateProfileEnableFirewall {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PrivateProfile"
        $Result.Number = '9.2.1'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Private: Firewall state' is set to 'On (recommended)'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.EnableFirewall.Value)
        $Result.SetCorrectly = $Result.Setting
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
9.2.2 (L1) Ensure 'Windows Firewall: Private: Inbound connections' is set to 'Block (default)'

.DESCRIPTION
This setting determines the behavior for inbound connections that do not match an inbound firewall rule.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PrivateProfileDefaultInboundAction

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.2.2      L1    Ensure 'Windows Firewall: Private: Inbound connections' is s... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-PrivateProfileDefaultInboundAction {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PrivateProfile"
        $Result.Number = '9.2.2'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Private: Inbound connections' is set to 'Block (default)'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.DefaultInboundAction.Value)
        $Result.SetCorrectly = $Result.Setting
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
9.2.3 (L1) Ensure 'Windows Firewall: Private: Outbound connections' is set to 'Allow (default)'

.DESCRIPTION
This setting determines the behavior for outbound connections that do not match an outbound firewall rule.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PrivateProfileDefaultOutboundAction

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.2.3      L1    Ensure 'Windows Firewall: Private: Outbound connections' is ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-PrivateProfileDefaultOutboundAction {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PrivateProfile"
        $Result.Number = '9.2.3'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Private: Outbound connections' is set to 'Allow (default)'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.DefaultOutboundAction.Value)
        $Result.SetCorrectly = -not($Result.Setting)
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
9.2.4 (L1) Ensure 'Windows Firewall: Private: Settings: Display a notification' is set to 'No'

.DESCRIPTION
Select this option to have Windows Firewall with Advanced Security display notifications to the user when a program is blocked from receiving inbound connections.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PrivateProfileDisableNotifications

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.2.4      L1    Ensure 'Windows Firewall: Private: Settings: Display a notif... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-PrivateProfileDisableNotifications {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PrivateProfile"
        $Result.Number = '9.2.4'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Private: Settings: Display a notification' is set to 'No'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.DisableNotifications.Value)
        $Result.SetCorrectly = $Result.Setting
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
9.2.5 (L1) Ensure 'Windows Firewall: Private: Logging: Name' is set to '%SystemRoot%\System32\logfiles\firewall\privatefw.log'

.DESCRIPTION
Use this option to specify the path and name of the file in which Windows Firewall will write its log information.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PrivateProfileLogFilePath

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.2.5      L1    Ensure 'Windows Firewall: Private: Logging: Name' is set to ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-PrivateProfileLogFilePath {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PrivateProfile"
        $Result.Number = '9.2.5'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Private: Logging: Name' is set to '%SystemRoot%\System32\logfiles\firewall\privatefw.log'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = $Result.Entry.LogFilePath.Value
        if ($Result.Setting -eq "%systemroot%\system32\logfiles\firewall\privatefw.log") {
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
9.2.6 (L1) Ensure 'Windows Firewall: Private: Logging: Size limit (KB)' is set to '16,384 KB or greater'

.DESCRIPTION
Use this option to specify the size limit of the file in which Windows Firewall will write its log information.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PrivateProfileLogFileSize

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.2.6      L1    Ensure 'Windows Firewall: Private: Logging: Size limit (KB)'... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-PrivateProfileLogFileSize {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PrivateProfile"
        $Result.Number = '9.2.6'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Private: Logging: Size limit (KB)' is set to '16,384 KB or greater'"
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
        return $Result
    }
}

<#
.SYNOPSIS
9.2.7 (L1) Ensure 'Windows Firewall: Private: Logging: Log dropped packets' is set to 'Yes'

.DESCRIPTION
Use this option to log when Windows Firewall with Advanced Security discards an inbound packet for any reason. The log records why and when the packet was dropped.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PrivateProfileLogDroppedPackets

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.2.7      L1    Ensure 'Windows Firewall: Private: Logging: Log dropped pack... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-PrivateProfileLogDroppedPackets {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PrivateProfile"
        $Result.Number = '9.2.7'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Private: Logging: Log dropped packets' is set to 'Yes'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.LogDroppedPackets.Value)
        $Result.SetCorrectly = $Result.Setting
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
9.2.8 (L1) Ensure 'Windows Firewall: Private: Logging: Log successful connections' is set to 'Yes'

.DESCRIPTION
Use this option to log when Windows Firewall with Advanced Security allows an inbound connection. The log records why and when the connection was formed.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PrivateProfileLogSuccessfulConnections

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.2.8      L1    Ensure 'Windows Firewall: Private: Logging: Log successful c... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-PrivateProfileLogSuccessfulConnections {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "PrivateProfile"
        $Result.Number = '9.2.8'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Windows Firewall: Private: Logging: Log successful connections' is set to 'Yes'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.LogSuccessfulConnections.Value)
        $Result.SetCorrectly = $Result.Setting
    }

    end {
        return $Result
    }
}

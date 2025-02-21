<#
.SYNOPSIS
9.1.1 (L1) Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On (recommended)'

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
Test-DomainProfileEnableFirewall

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.1.1      L1    Ensure 'Windows Firewall: Domain: Firewall state' is set to ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainProfileEnableFirewall {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Number = '9.1.1'
        $Level = 'L1'
        
        $Title= "Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On (recommended)'"
        $Source = 'FixMe'

        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.EnableFirewall.Value)
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

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainProfileDefaultInboundAction

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.1.2      L1    Ensure 'Windows Firewall: Domain: Inbound connections' is se... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainProfileDefaultInboundAction {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Number = '9.1.2'
        $Level = 'L1'
        
        $Title= "Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'Block (default)'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.DefaultInboundAction.Value)
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

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainProfileDefaultOutboundAction

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.1.3      L1    Ensure 'Windows Firewall: Domain: Outbound connections' is s... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainProfileDefaultOutboundAction {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Number = '9.1.3'
        $Level = 'L1'
        
        $Title= "Ensure 'Windows Firewall: Domain: Outbound connections' is set to 'Allow (default)'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        if ($Result.Entry) {
            $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.DefaultOutboundAction.Value)
            $Result.SetCorrectly = -not($Result.Setting)
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
9.1.4 (L1) Ensure 'Windows Firewall: Domain: Settings: Display a notification' is set to 'No'

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
Test-DomainProfileDisableNotifications

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.1.4      L1    Ensure 'Windows Firewall: Domain: Settings: Display a notifi... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainProfileDisableNotifications {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Number = '9.1.4'
        $Level = 'L1'
        
        $Title= "Ensure 'Windows Firewall: Domain: Settings: Display a notification' is set to 'No'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.DisableNotifications.Value)
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

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainProfileLogFilePath

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.1.5      L1    Ensure 'Windows Firewall: Domain: Logging: Name' is set to '... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainProfileLogFilePath {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Number = '9.1.5'
        $Level = 'L1'
        
        $Title= "Ensure 'Windows Firewall: Domain: Logging: Name' is set to '%SystemRoot%\System32\logfiles\firewall\domainfw.log'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = $Result.Entry.LogFilePath.Value
        if ($Result.Setting -eq "%systemroot%\system32\logfiles\firewall\domainfw.log") {
            $Result.SetCorrectly = $true
        } elseif ($Result.Setting -ne "%systemroot%\system32\logfiles\firewall\pfirewall.log" -and $Result.Setting.GetType().Name -eq "String") {
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

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainProfileLogFileSize

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.1.6      L1    Ensure 'Windows Firewall: Domain: Logging: Size limit (KB)' ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainProfileLogFileSize {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Number = '9.1.6'
        $Level = 'L1'
        
        $Title= "Ensure 'Windows Firewall: Domain: Logging: Size limit (KB)' is set to '16,384 KB or greater'"
        $Source = 'FixMe'

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

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainProfileLogDroppedPackets

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.1.7      L1    Ensure 'Windows Firewall: Domain: Logging: Log dropped packe... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainProfileLogDroppedPackets {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Number = '9.1.7'
        $Level = 'L1'
        
        $Title= "Ensure 'Windows Firewall: Domain: Logging: Log dropped packets' is set to 'Yes'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.LogDroppedPackets.Value)
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

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainProfileLogSuccessfulConnections

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
9.1.8      L1    Ensure 'Windows Firewall: Domain: Logging: Log successful co... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainProfileLogSuccessfulConnections {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "DomainProfile"
        $Number = '9.1.8'
        $Level = 'L1'
        
        $Title= "Ensure 'Windows Firewall: Domain: Logging: Log successful connections' is set to 'Yes'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-WindowsFirewallSettings -EntryName $EntryName -GPResult $GPResult
    }

    process {
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.LogSuccessfulConnections.Value)
        $Result.SetCorrectly = $Result.Setting
    }

    end {
        Return $Result
    }
}

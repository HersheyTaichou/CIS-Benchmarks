<#
.SYNOPSIS
18.4.1 (L1) Ensure 'Apply UAC restrictions to local accounts on network logons' is set to 'Enabled' (MS only)

.DESCRIPTION
This setting controls whether local accounts can be used for remote administration via network logon (e.g., NET USE, connecting to C$, etc.). Local accounts are at high risk for credential theft when the same account and password is configured on multiple systems. Enabling this policy significantly reduces that risk.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MSSecurityGuideApplyUACRestrictionsToLocalAccountsOnNetworkLogons

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-MSSecurityGuideApplyUACRestrictionsToLocalAccountsOnNetworkLogons {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Apply UAC restrictions to local accounts on network logons"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.4.1'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Apply UAC restrictions to local accounts on network logons' is set to 'Enabled' (MS only)"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.State
        if ($Result.Entry.State -eq "Enabled") {
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
18.4.2 (L1) Ensure 'Configure RPC packet level privacy setting for incoming connections' is set to 'Enabled'

.DESCRIPTION
This policy setting controls packet level privacy for Remote Procedure Call (RPC) incoming connections.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MSSecurityGuideConfigureRPCPacketLevelPrivacySettingForIncomingConnections

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
When tested, this setting was not in the Server 2022 ADMX file. The Windows 11 22H2 policies had to be applied in AD. 
#>
function Test-MSSecurityGuideConfigureRPCPacketLevelPrivacySettingForIncomingConnections {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Configure RPC packet level privacy setting for incoming connections"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.4.2'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Configure RPC packet level privacy setting for incoming connections' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.State
        if ($Result.Entry.State -eq "Enabled") {
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
18.4.3 (L1) Ensure 'Configure SMB v1 client driver' is set to 'Enabled: Disable driver (recommended)'

.DESCRIPTION
This setting configures the start type for the Server Message Block version 1 (SMBv1) client driver service (MRxSmb10), which is recommended to be disabled.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MSSecurityGuideConfigureSMBv1ClientDriver

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-MSSecurityGuideConfigureSMBv1ClientDriver {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Configure SMB v1 client driver"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.4.3'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Configure SMB v1 client driver' is set to 'Enabled: Disable driver (recommended)'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.DropDownList.Value.Name
        if (($Result.Entry.State -eq "Enabled") -and ($Result.Setting -eq "Disable driver (recommended)")) {
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
18.4.4 (L1) Ensure 'Configure SMB v1 server' is set to 'Disabled'

.DESCRIPTION
This setting configures the server-side processing of the Server Message Block version 1 (SMBv1) protocol.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MSSecurityGuideConfigureSMBv1Server

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-MSSecurityGuideConfigureSMBv1Server {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Configure SMB v1 server"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.4.4'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Configure SMB v1 server' is set to 'Disabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.State
        if ($Result.Setting -eq "Disabled") {
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
18.4.5 (L1) Ensure 'Enable Structured Exception Handling Overwrite Protection (SEHOP)' is set to 'Enabled'

.DESCRIPTION
Windows includes support for Structured Exception Handling Overwrite Protection (SEHOP). We recommend enabling this feature to improve the security profile of the computer.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MSSecurityGuideEnableSEHOP

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-MSSecurityGuideEnableSEHOP {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Enable Structured Exception Handling Overwrite Protection (SEHOP)"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.4.5'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Enable Structured Exception Handling Overwrite Protection (SEHOP)' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.State
        if ($Result.Entry.State -eq "Enabled") {
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
18.4.6 (L1) Ensure 'NetBT NodeType configuration' is set to 'Enabled: P-node (recommended)'

.DESCRIPTION
This setting determines which method NetBIOS over TCP/IP (NetBT) uses to register and resolve names.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MSSecurityGuideNetBTNodeTypeconfiguration

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-MSSecurityGuideNetBTNodeTypeconfiguration {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "NetBT NodeType configuration"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.4.6'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'NetBT NodeType configuration' is set to 'Enabled: P-node (recommended)'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.DropDownList.Value.Name
        if (($Result.Entry.State -eq "Enabled") -and ($Result.Setting -eq "P-node (recommended)")) {
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
18.4.7 (L1) Ensure 'WDigest Authentication' is set to 'Disabled'

.DESCRIPTION
When WDigest authentication is enabled, Lsass.exe retains a copy of the user's plaintext password in memory, where it can be at risk of theft.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MSSecurityGuideWDigestAuthentication

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-MSSecurityGuideWDigestAuthentication {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "WDigest Authentication (disabling may require KB2871997)"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.4.7'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'WDigest Authentication' is set to 'Disabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.State
        if ($Result.Entry.State -eq "Disabled") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

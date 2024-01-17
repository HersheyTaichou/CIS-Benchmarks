<#
.SYNOPSIS
2.3.9.1 (L1) Ensure 'Microsoft network server: Amount of idle time required before suspending session' is set to '15 or fewer minute(s)'

.DESCRIPTION
This policy setting allows you to specify the amount of continuous idle time that must pass in an SMB session before the session is suspended because of inactivity.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MicrosoftNetworkServerAutoDisconnect

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.9.1    L1    Ensure 'Microsoft network server: Amount of idle time requir... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-MicrosoftNetworkServerAutoDisconnect {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\AutoDisconnect"
        $Result.Number = '2.3.9.1'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Microsoft network server: Amount of idle time required before suspending session' is set to '15 or fewer minute(s)'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingNumber
        if (($Result.Setting) -and ($Result.Setting -le 15)) {
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
2.3.9.2 (L1) Ensure 'Microsoft network server: Digitally sign communications (always)' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether packet signing is required by the SMB server component.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MicrosoftNetworkServerRequireSecuritySignature

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.9.2    L1    Ensure 'Microsoft network server: Digitally sign communicati... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-MicrosoftNetworkServerRequireSecuritySignature {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\RequireSecuritySignature"
        $Result.Number = '2.3.9.2'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Microsoft network server: Digitally sign communications (always)' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry.KeyName) {
            $Result.SetCorrectly = $Result.Setting
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
2.3.9.3 (L1) Ensure 'Microsoft network server: Digitally sign communications (if client agrees)' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether the SMB server will negotiate SMB packet signing with clients that request it. If no signing request comes from the client, a connection will be allowed without a signature if the "Microsoft network server: Digitally sign communications (always)" setting is not enabled.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MicrosoftNetworkServerEnableSecuritySignature

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.9.3    L1    Ensure 'Microsoft network server: Digitally sign communicati... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-MicrosoftNetworkServerEnableSecuritySignature {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\EnableSecuritySignature"
        $Result.Number = '2.3.9.3'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Microsoft network server: Digitally sign communications (if client agrees)' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry.KeyName) {
            $Result.SetCorrectly = $Result.Setting
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
2.3.9.4 (L1) Ensure 'Microsoft network server: Disconnect clients when logon hours expire' is set to 'Enabled'

.DESCRIPTION
This security setting determines whether to disconnect users who are connected to the local computer outside their user account's valid logon hours. This setting affects the Server Message Block (SMB) component. If you enable this policy setting you should also enable "Network security: Force logoff when logon hours expire".

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MicrosoftNetworkServerEnableForcedLogOff

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.9.4    L1    Ensure 'Microsoft network server: Disconnect clients when lo... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-MicrosoftNetworkServerEnableForcedLogOff {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\EnableForcedLogOff"
        $Result.Number = '2.3.9.4'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Microsoft network server: Disconnect clients when logon hours expire' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry.KeyName) {
            $Result.SetCorrectly = $Result.Setting
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
2.3.9.5 (L1) Ensure 'Microsoft network server: Server SPN target name validation level' is set to 'Accept if provided by client' or higher (MS only)

.DESCRIPTION
This policy setting controls the level of validation a computer with shared folders or printers (the server) performs on the service principal name (SPN) that is provided by the client computer when it establishes a session using the server message block (SMB) protocol.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MicrosoftNetworkServerSmbServerNameHardeningLevel

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.9.5    L1    Ensure 'Microsoft network server: Server SPN target name val... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-MicrosoftNetworkServerSmbServerNameHardeningLevel {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\SmbServerNameHardeningLevel"
        $Result.Number = '2.3.9.5'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Microsoft network server: Server SPN target name validation level' is set to 'Accept if provided by client' or higher (MS only)"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingNumber
        if (($Result.Setting) -and ($Result.Setting -ge 1) -and ($ProductType -eq 3)) {
            $Result.SetCorrectly = $true
        } elseif (($ProductType -eq 2) -and ($Result.Setting -ge 1)) {
            Write-Warning "$($Result.Number): `"$($Result.Title)`" On Domain Controllers, if Hardened UNC Paths (18.6.14.1) is enabled, this setting can lead to significant issues."
            $Result.SetCorrectly = $false
        } elseif (($ProductType -eq 2) -and (-not($Result.Setting))) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

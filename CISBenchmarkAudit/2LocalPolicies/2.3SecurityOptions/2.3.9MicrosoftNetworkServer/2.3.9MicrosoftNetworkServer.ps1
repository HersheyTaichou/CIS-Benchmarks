<#
.SYNOPSIS
2.3.9.1 (L1) Ensure 'Microsoft network server: Amount of idle time required before suspending session' is set to '15 or fewer minute(s)'

.DESCRIPTION
This policy setting allows you to specify the amount of continuous idle time that must pass in an SMB session before the session is suspended because of inactivity.

.EXAMPLE
Test-MicrosoftNetworkServerAutoDisconnect

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.9.1   (L1) Ensure 'Microsoft network server: Amount of idle time required before suspending session' i... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-MicrosoftNetworkServerAutoDisconnect {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\AutoDisconnect"
        $RecommendationNumber = '2.3.9.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Microsoft network server: Amount of idle time required before suspending session' is set to '15 or fewer minute(s)'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Setting = [int]$Entry.SettingNumber
        if (($Setting) -and ($Setting -le 15)) {
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
2.3.9.2 (L1) Ensure 'Microsoft network server: Digitally sign communications (always)' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether packet signing is required by the SMB server component.

.EXAMPLE
Test-MicrosoftNetworkServerRequireSecuritySignature

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.9.2   (L1) Ensure 'Microsoft network server: Digitally sign communications (always)' is set to 'Enabled'  Group Policy Settings     True    

.NOTES
General notes
#>
function Test-MicrosoftNetworkServerRequireSecuritySignature {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\RequireSecuritySignature"
        $RecommendationNumber = '2.3.9.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Microsoft network server: Digitally sign communications (always)' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.KeyName) {
            $Pass = $Setting
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
2.3.9.3 (L1) Ensure 'Microsoft network server: Digitally sign communications (if client agrees)' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether the SMB server will negotiate SMB packet signing with clients that request it. If no signing request comes from the client, a connection will be allowed without a signature if the "Microsoft network server: Digitally sign communications (always)" setting is not enabled.

.EXAMPLE
Test-MicrosoftNetworkServerEnableSecuritySignature

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.9.3   (L1) Ensure 'Microsoft network server: Digitally sign communications (if client agrees)' is set ... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-MicrosoftNetworkServerEnableSecuritySignature {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\EnableSecuritySignature"
        $RecommendationNumber = '2.3.9.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Microsoft network server: Digitally sign communications (if client agrees)' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.KeyName) {
            $Pass = $Setting
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
2.3.9.4 (L1) Ensure 'Microsoft network server: Disconnect clients when logon hours expire' is set to 'Enabled'

.DESCRIPTION
This security setting determines whether to disconnect users who are connected to the local computer outside their user account's valid logon hours. This setting affects the Server Message Block (SMB) component. If you enable this policy setting you should also enable "Network security: Force logoff when logon hours expire".

.EXAMPLE
Test-MicrosoftNetworkServerEnableForcedLogOff

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.9.4   (L1) Ensure 'Microsoft network server: Disconnect clients when logon hours expire' is set to 'En... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-MicrosoftNetworkServerEnableForcedLogOff {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\EnableForcedLogOff"
        $RecommendationNumber = '2.3.9.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Microsoft network server: Disconnect clients when logon hours expire' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.KeyName) {
            $Pass = $Setting
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
2.3.9.5 (L1) Ensure 'Microsoft network server: Server SPN target name validation level' is set to 'Accept if provided by client' or higher (MS only)

.DESCRIPTION
This policy setting controls the level of validation a computer with shared folders or printers (the server) performs on the service principal name (SPN) that is provided by the client computer when it establishes a session using the server message block (SMB) protocol.

.EXAMPLE
Test-MicrosoftNetworkServerSmbServerNameHardeningLevel

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.9.5   (L1) Ensure 'Microsoft network server: Server SPN target name validation level' is set to 'Accep... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-MicrosoftNetworkServerSmbServerNameHardeningLevel {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $ServerType = Get-ProductType
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\SmbServerNameHardeningLevel"
        $RecommendationNumber = '2.3.9.5'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Microsoft network server: Server SPN target name validation level' is set to 'Accept if provided by client' or higher (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Setting = [int]$Entry.SettingNumber
        if (($Setting) -and ($Setting -ge 1) -and ($ServerType -eq 3)) {
            $Pass = $true
        } elseif (($ServerType -eq 2) -and ($Setting -ge 1)) {
            $Pass = $false
            Write-Warning "On Domain Controllers, if 18.5.14.1 is enabled, this setting can lead to significant issues."
        } elseif (($ServerType -eq 2) -and (-not($Setting))) {
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

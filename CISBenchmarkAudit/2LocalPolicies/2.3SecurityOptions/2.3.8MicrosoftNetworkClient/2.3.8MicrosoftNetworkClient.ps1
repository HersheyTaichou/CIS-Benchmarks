<#
.SYNOPSIS
2.3.8.1 (L1) Ensure 'Microsoft network client: Digitally sign communications (always)' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether packet signing is required by the SMB client component.

.EXAMPLE
Test-MicrosoftNetworkClientRequireSecuritySignature

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.8.1   (L1) Ensure 'Microsoft network client: Digitally sign communications (always)' is set to 'Enabled'  Group Policy Settings     True    

.NOTES
General notes
#>
function Test-MicrosoftNetworkClientRequireSecuritySignature {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\RequireSecuritySignature"
        $RecommendationNumber = '2.3.8.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Microsoft network client: Digitally sign communications (always)' is set to 'Enabled'"
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
2.3.8.2 (L1) Ensure 'Microsoft network client: Digitally sign communications (if server agrees)' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether the SMB client will attempt to negotiate SMB packet signing.

.EXAMPLE
Test-MicrosoftNetworkClientEnableSecuritySignature

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.8.2   (L1) Ensure 'Microsoft network client: Digitally sign communications (if server agrees)' is set ... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-MicrosoftNetworkClientEnableSecuritySignature {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\EnableSecuritySignature"
        $RecommendationNumber = '2.3.8.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Microsoft network client: Digitally sign communications (if server agrees)' is set to 'Enabled'"
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
2.3.8.3 (L1) Ensure 'Microsoft network client: Send unencrypted password to third-party SMB servers' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether the SMB redirector will send plaintext passwords during authentication to third-party SMB servers that do not support password encryption.

.EXAMPLE
Test-MicrosoftNetworkClientEnablePlainTextPassword

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.8.3   (L1) Ensure 'Microsoft network client: Send unencrypted password to third-party SMB servers' is ... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-MicrosoftNetworkClientEnablePlainTextPassword {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\EnablePlainTextPassword"
        $RecommendationNumber = '2.3.8.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Microsoft network client: Send unencrypted password to third-party SMB servers' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry) {
            if ($Setting) {
                $Pass = $false
            } elseif ($setting -eq $false) {
                $Pass = $true
            } else {
                $Pass = $false
            }
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

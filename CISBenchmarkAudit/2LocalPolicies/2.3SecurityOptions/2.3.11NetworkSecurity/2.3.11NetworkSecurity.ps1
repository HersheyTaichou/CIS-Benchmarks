<#
.SYNOPSIS
2.3.11.1 (L1) Ensure 'Network security: Allow Local System to use computer identity for NTLM' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether Local System services that use Negotiate when reverting to NTLM authentication can use the computer identity.

.EXAMPLE
Test-NetworkSecurityUseMachineId

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.11.1  (L1) Ensure 'Network security: Allow Local System to use computer identity for NTLM' is set to '... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkSecurityUseMachineId {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\UseMachineId"
        $RecommendationNumber = '2.3.11.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network security: Allow Local System to use computer identity for NTLM' is set to 'Enabled'"
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
2.3.11.2 (L1) Ensure 'Network security: Allow LocalSystem NULL session fallback' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether NTLM is allowed to fall back to a NULL session when used with LocalSystem.

.EXAMPLE
Test-NetworkSecurityAllowNullSessionFallback

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.11.2  (L1) Ensure 'Network security: Allow LocalSystem NULL session fallback' is set to 'Disabled'        Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkSecurityAllowNullSessionFallback {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0\allownullsessionfallback"
        $RecommendationNumber = '2.3.11.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network security: Allow LocalSystem NULL session fallback' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.KeyName) {
            $Pass = -not($setting)
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
2.3.11.3 (L1) Ensure 'Network Security: Allow PKU2U authentication requests to this computer to use online identities' is set to 'Disabled'

.DESCRIPTION
This setting determines if online identities are able to authenticate to this computer.

.EXAMPLE
Test-NetworkSecurityAllowOnlineID

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.11.3  (L1) Ensure 'Network Security: Allow PKU2U authentication requests to this computer to use onlin... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkSecurityAllowOnlineID {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\pku2u\AllowOnlineID"
        $RecommendationNumber = '2.3.11.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network Security: Allow PKU2U authentication requests to this computer to use online identities' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.KeyName) {
            $Pass = -not($setting)
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
2.3.11.4 (L1) Ensure 'Network security: Configure encryption types allowed for Kerberos' is set to 'AES128_HMAC_SHA1, AES256_HMAC_SHA1, Future encryption types'

.DESCRIPTION
This policy setting allows you to set the encryption types that Kerberos is allowed to use.

.EXAMPLE
Test-NetworkSecuritySupportedEncryptionTypes

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.11.4  (L1) Ensure 'Network security: Configure encryption types allowed for Kerberos' is set to 'AES12... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkSecuritySupportedEncryptionTypes {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters\SupportedEncryptionTypes"
        $RecommendationNumber = '2.3.11.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network security: Configure encryption types allowed for Kerberos' is set to 'AES128_HMAC_SHA1, AES256_HMAC_SHA1, Future encryption types'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Entry.Display.DisplayFields.Field| ForEach-Object {$Setting += $_.Name + "," + $_.Value + "; "}
        if ($Entry.SettingNumber -eq 2147483640) {
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
2.3.11.5 (L1) Ensure 'Network security: Do not store LAN Manager hash value on next password change' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether the LAN Manager (LM) hash value for the new password is stored when the password is changed. The LM hash is relatively weak and prone to attack compared to the cryptographically stronger Microsoft Windows NT hash. Since LM hashes are stored on the local computer in the security database, passwords can then be easily compromised if the database is attacked.

.EXAMPLE
Test-NetworkSecurityNoLMHash

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.11.5  (L1) Ensure 'Network security: Do not store LAN Manager hash value on next password change' is s... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkSecurityNoLMHash {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\NoLMHash"
        $RecommendationNumber = '2.3.11.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network security: Do not store LAN Manager hash value on next password change' is set to 'Enabled'"
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
2.3.11.6 (L1) Ensure 'Network security: Force logoff when logon hours expire' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether to disconnect users who are connected to the local computer outside their user account's valid logon hours.

.EXAMPLE
Test-NetworkSecurityForceLogoffWhenHourExpire

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.11.6  (L1) Ensure 'Network security: Force logoff when logon hours expire' is set to 'Enabled'            Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkSecurityForceLogoffWhenHourExpire {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "ForceLogoffWhenHourExpire"
        $RecommendationNumber = '2.3.11.6'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network security: Force logoff when logon hours expire' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SystemAccessPolicyName" -GPResult $GPResult
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.SystemAccessPolicyName) {
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
2.3.11.7 (L1) Ensure 'Network security: LAN Manager authentication level' is set to 'Send NTLMv2 response only. Refuse LM & NTLM'

.DESCRIPTION
The Network security: LAN Manager authentication level setting determines which challenge/response authentication protocol is used for network logons. This choice affects the level of authentication protocol used by clients, the level of session security negotiated, and the level of authentication accepted by servers.

.EXAMPLE
Test-NetworkSecurityLmCompatibilityLevel

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.11.7  (L1) Ensure 'Network security: LAN Manager authentication level' is set to 'Send NTLMv2 response... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkSecurityLmCompatibilityLevel {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\LmCompatibilityLevel"
        $RecommendationNumber = '2.3.11.7'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network security: LAN Manager authentication level' is set to 'Send NTLMv2 response only. Refuse LM & NTLM'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Setting = $Entry.Display.DisplayString
        if ([int]$Entry.SettingNumber -eq 5) {
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
2.3.11.8 (L1) Ensure 'Network security: LDAP client signing requirements' is set to 'Negotiate signing' or higher

.DESCRIPTION
This policy setting determines the level of data signing that is requested on behalf of clients that issue LDAP BIND requests.

.EXAMPLE
Test-NetworkSecurityLDAPClientIntegrity

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.11.8  (L1) Ensure 'Network security: LDAP client signing requirements' is set to 'Negotiate signing' o... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkSecurityLDAPClientIntegrity {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LDAP\LDAPClientIntegrity"
        $RecommendationNumber = '2.3.11.8'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network security: LDAP client signing requirements' is set to 'Negotiate signing' or higher"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Setting = $Entry.Display.DisplayString
        if ([int]$Entry.SettingNumber -ge 1) {
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
2.3.11.9 (L1) Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC) clients' is set to 'Require NTLMv2 session security, Require 128-bit encryption'

.DESCRIPTION
This policy setting determines which behaviors are allowed by clients for applications using the NTLM Security Support Provider (SSP).

.EXAMPLE
Test-NetworkSecurityNTLMMinClientSec

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.11.9  (L1) Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkSecurityNTLMMinClientSec {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0\NTLMMinClientSec"
        $RecommendationNumber = '2.3.11.9'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC) clients' is set to 'Require NTLMv2 session security, Require 128-bit encryption'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Entry.Display.DisplayFields.Field | ForEach-Object {$Setting += $_.Name + "," + $_.Value + "; "}
        if ([int]$Entry.SettingNumber -eq 537395200) {
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
2.3.11.10 (L1) Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC) servers' is set to 'Require NTLMv2 session security, Require 128-bit encryption'

.DESCRIPTION
This policy setting determines which behaviors are allowed by servers for applications using the NTLM Security Support Provider (SSP).

.EXAMPLE
Test-NetworkSecurityNTLMMinServerSec

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.11.10 (L1) Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkSecurityNTLMMinServerSec {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0\NTLMMinClientSec"
        $RecommendationNumber = '2.3.11.10'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC) servers' is set to 'Require NTLMv2 session security, Require 128-bit encryption'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        $Entry.Display.DisplayFields.Field | ForEach-Object {$Setting += $_.Name + "," + $_.Value + "; "}
        if ([int]$Entry.SettingNumber -eq 537395200) {
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

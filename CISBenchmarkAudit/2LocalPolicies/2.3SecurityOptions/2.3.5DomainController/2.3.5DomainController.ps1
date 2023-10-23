<#
.SYNOPSIS
2.3.5.1 (L1) Ensure 'Domain controller: Allow server operators to schedule tasks' is set to 'Disabled' (DC only)

.DESCRIPTION
This policy setting determines whether members of the Server Operators group are allowed to submit jobs by means of the AT schedule facility.

.EXAMPLE
Test-DomainControllerSubmitControl

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.5.1   (L1) Ensure 'Domain controller: Allow server operators to schedule tasks' is set to 'Disabled' (... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-DomainControllerSubmitControl {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\SubmitControl"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
        [bool]$Setting = [int]$Entry.SettingNumber
    }

    process {
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
        $RecommendationNumber = '2.3.5.1'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Domain controller: Allow server operators to schedule tasks' is set to 'Disabled' (DC only)"
        $Source = 'Group Policy Settings'
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
2.3.5.2 (L1) Ensure 'Domain controller: Allow vulnerable Netlogon secure channel connections' is set to 'Not Configured' (DC Only)

.DESCRIPTION
This security setting determines whether the domain controller bypasses secure RPC for Netlogon secure channel connections for specified machine accounts.

.EXAMPLE
Test-DomainControllerVulnerableChannelAllowList

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.5.2   (L1) Ensure 'Domain controller: Allow vulnerable Netlogon secure channel connections' is set to ... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-DomainControllerVulnerableChannelAllowList {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\VulnerableChannelAllowList"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        if ($Entry) {
            $Pass = $false
        } else {
            $Pass = $true
        }
    }

    end {
        $RecommendationNumber = '2.3.5.2'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Domain controller: Allow vulnerable Netlogon secure channel connections' is set to 'Not Configured'"
        $Source = 'Group Policy Settings'
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
2.3.5.3 (L1) Ensure 'Domain controller: LDAP server channel binding token requirements' is set to 'Always' (DC Only)

.DESCRIPTION
This setting determines whether the LDAP server (Domain Controller) enforces validation of Channel Binding Tokens (CBT) received in LDAP bind requests that are sent over SSL/TLS (i.e. LDAPS).

.EXAMPLE
Test-DomainControllerLdapEnforceChannelBinding

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.5.3   (L1) Ensure 'Domain controller: LDAP server channel binding token requirements' is set to 'Always'  Group Policy Settings     True    

.NOTES
General notes
#>
function Test-DomainControllerLdapEnforceChannelBinding {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        $EntryName = "MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\LdapEnforceChannelBinding"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
        [string]$Setting = $Entry.Display.DisplayString
    }

    process {
        if ($Setting -eq "Always") {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $RecommendationNumber = '2.3.5.3'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Domain controller: LDAP server channel binding token requirements' is set to 'Always'"
        $Source = 'Group Policy Settings'
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
2.3.5.4 (L1) Ensure 'Domain controller: LDAP server signing requirements' is set to 'Require signing' (DC only)

.DESCRIPTION
This policy setting determines whether the Lightweight Directory Access Protocol (LDAP) server requires LDAP clients to negotiate data signing.

.EXAMPLE
Test-DomainControllerLDAPServerIntegrity

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.5.4   (L1) Ensure 'Domain controller: LDAP server signing requirements' is set to 'Require signing' (D... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-DomainControllerLDAPServerIntegrity {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\LDAPServerIntegrity"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
        [string]$Setting = $Entry.Display.DisplayString
    }

    process {
        if ($Setting -eq "Require signing") {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $RecommendationNumber = '2.3.5.4'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Domain controller: LDAP server signing requirements' is set to 'Require signing' (DC only)"
        $Source = 'Group Policy Settings'
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
2.3.5.5 (L1) Ensure 'Domain controller: Refuse machine account password changes' is set to 'Disabled' (DC only)

.DESCRIPTION
This security setting determines whether Domain Controllers will refuse requests from member computers to change computer account passwords.

.EXAMPLE
Test-DomainControllerRefusePasswordChange

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.5.5   (L1) Ensure 'Domain controller: Refuse machine account password changes' is set to 'Disabled' (D... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-DomainControllerRefusePasswordChange {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RefusePasswordChange"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
        [bool]$Setting = [int]$Entry.SettingNumber
    }

    process {
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
        $RecommendationNumber = '2.3.5.5'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Domain controller: Refuse machine account password changes' is set to 'Disabled' (DC only)"
        $Source = 'Group Policy Settings'
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

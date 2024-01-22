<#
.SYNOPSIS
2.3.5.1 (L1) Ensure 'Domain controller: Allow server operators to schedule tasks' is set to 'Disabled' (DC only)

.DESCRIPTION
This policy setting determines whether members of the Server Operators group are allowed to submit jobs by means of the AT schedule facility.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainControllerSubmitControl

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.5.1    L1    Ensure 'Domain controller: Allow server operators to schedul... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainControllerSubmitControl {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\SubmitControl"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        if ($Result.Entry) {
            $Result.SetCorrectly = -not($Result.Setting)
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Result.Number = '2.3.5.1'
        $Result.Level = "L1"
        $Result.Profile = "Domain Controller"
        $Result.Title = "Ensure 'Domain controller: Allow server operators to schedule tasks' is set to 'Disabled' (DC only)"
        $Result.Source = 'Group Policy Settings'
        return $Result
    }
}

<#
.SYNOPSIS
2.3.5.2 (L1) Ensure 'Domain controller: Allow vulnerable Netlogon secure channel connections' is set to 'Not Configured' (DC Only)

.DESCRIPTION
This security setting determines whether the domain controller bypasses secure RPC for Netlogon secure channel connections for specified machine accounts.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainControllerVulnerableChannelAllowList

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.5.2    L1    Ensure 'Domain controller: Allow vulnerable Netlogon secure ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainControllerVulnerableChannelAllowList {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\VulnerableChannelAllowList"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
    }

    process {
        if ($Result.Entry) {
            $Result.SetCorrectly = $false
        } else {
            $Result.SetCorrectly = $true
        }
    }

    end {
        $Result.Number = '2.3.5.2'
        $Result.Level = "L1"
        $Result.Profile = "Domain Controller"
        $Result.Title = "Ensure 'Domain controller: Allow vulnerable Netlogon secure channel connections' is set to 'Not Configured'"
        $Result.Source = 'Group Policy Settings'
        return $Result
    }
}

<#
.SYNOPSIS
2.3.5.3 (L1) Ensure 'Domain controller: LDAP server channel binding token requirements' is set to 'Always' (DC Only)

.DESCRIPTION
This setting determines whether the LDAP server (Domain Controller) enforces validation of Channel Binding Tokens (CBT) received in LDAP bind requests that are sent over SSL/TLS (i.e. LDAPS).

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainControllerLdapEnforceChannelBinding

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.5.3    L1    Ensure 'Domain controller: LDAP server channel binding token... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainControllerLdapEnforceChannelBinding {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        $EntryName = "MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\LdapEnforceChannelBinding"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
        [string]$Result.Setting = $Result.Entry.Display.DisplayString
    }

    process {
        if ($Result.Setting -eq "Always") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Result.Number = '2.3.5.3'
        $Result.Level = "L1"
        $Result.Profile = "Domain Controller"
        $Result.Title = "Ensure 'Domain controller: LDAP server channel binding token requirements' is set to 'Always'"
        $Result.Source = 'Group Policy Settings'
        return $Result
    }
}

<#
.SYNOPSIS
2.3.5.4 (L1) Ensure 'Domain controller: LDAP server signing requirements' is set to 'Require signing' (DC only)

.DESCRIPTION
This policy setting determines whether the Lightweight Directory Access Protocol (LDAP) server requires LDAP clients to negotiate data signing.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainControllerLDAPServerIntegrity

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.5.4    L1    Ensure 'Domain controller: LDAP server signing requirements'... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainControllerLDAPServerIntegrity {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\LDAPServerIntegrity"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
        [string]$Result.Setting = $Result.Entry.Display.DisplayString
    }

    process {
        if ($Result.Setting -eq "Require signing") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Result.Number = '2.3.5.4'
        $Result.Level = "L1"
        $Result.Profile = "Domain Controller"
        $Result.Title = "Ensure 'Domain controller: LDAP server signing requirements' is set to 'Require signing' (DC only)"
        $Result.Source = 'Group Policy Settings'
        return $Result
    }
}

<#
.SYNOPSIS
2.3.5.5 (L1) Ensure 'Domain controller: Refuse machine account password changes' is set to 'Disabled' (DC only)

.DESCRIPTION
This security setting determines whether Domain Controllers will refuse requests from member computers to change computer account passwords.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainControllerRefusePasswordChange

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.5.5    L1    Ensure 'Domain controller: Refuse machine account password c... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainControllerRefusePasswordChange {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RefusePasswordChange"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        if ($Result.Entry) {
            $Result.SetCorrectly = -not($Result.Setting)
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Result.Number = '2.3.5.5'
        $Result.Level = "L1"
        $Result.Profile = "Domain Controller"
        $Result.Title = "Ensure 'Domain controller: Refuse machine account password changes' is set to 'Disabled' (DC only)"
        $Result.Source = 'Group Policy Settings'
        return $Result
    }
}

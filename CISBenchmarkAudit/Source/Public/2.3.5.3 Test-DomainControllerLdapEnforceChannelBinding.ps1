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
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        $EntryName = "MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\LdapEnforceChannelBinding"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
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
        $Number = '2.3.5.3'
        $Level = 'L1'
        $Result.Profile = "Domain Controller"
        $Title= "Ensure 'Domain controller: LDAP server channel binding token requirements' is set to 'Always'"
        $Source = 'FixMe'
        return $Result
    }
}

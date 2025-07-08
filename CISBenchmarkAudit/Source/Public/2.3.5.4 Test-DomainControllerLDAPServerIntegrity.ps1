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
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\LDAPServerIntegrity"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
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
        $Number = '2.3.5.4'
        $Level = 'L1'
        $Result.Profile = "Domain Controller"
        $Title= "Ensure 'Domain controller: LDAP server signing requirements' is set to 'Require signing' (DC only)"
        $Source = 'FixMe'
        return $Result
    }
}

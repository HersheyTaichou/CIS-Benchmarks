<#
.SYNOPSIS
2.3.1.4 (L1) Configure 'Accounts: Rename administrator account'

.DESCRIPTION
The built-in local administrator account is a well-known account name that attackers will target. It is recommended to choose another name for this account, and to avoid names that denote administrative or elevated access accounts.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountsNewAdministratorName

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.1.4    L1    Configure 'Accounts: Rename administrator account'              Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountsNewAdministratorName {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "NewAdministratorName"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SystemAccessPolicyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if (($Result.Entry) -and ($Result.Entry.SettingString -ne "Administrator")) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Number = '2.3.1.4'
        $Level = 'L1'
        
        $Title= "Configure 'Accounts: Rename administrator account'"
        $Source = 'FixMe'
        $Result.Setting = $Result.Entry.SettingString
            return $Result
    }
}


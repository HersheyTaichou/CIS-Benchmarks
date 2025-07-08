<#
.SYNOPSIS
2.3.1.5 (L1) Configure 'Accounts: Rename guest account'

.DESCRIPTION
The built-in local guest account is another well-known name to attackers. It is recommended to rename this account to something that does not indicate its purpose. Even if you disable this account, which is recommended, ensure that you rename it for added security.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountsNewGuestName

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.1.5    L1    Configure 'Accounts: Rename guest account'                      Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountsNewGuestName {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "NewGuestName"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SystemAccessPolicyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if (($Result.Entry) -and ($Result.Entry.SettingString -ne "Guest")) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Number = '2.3.1.5'
        $Level = 'L1'
        
        $Title= "Configure 'Accounts: Rename guest account'"
        $Source = 'FixMe'
        $Result.Setting = $Result.Entry.SettingString
            return $Result
    }
}

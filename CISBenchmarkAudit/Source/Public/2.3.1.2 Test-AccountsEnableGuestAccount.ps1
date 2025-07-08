<#
.SYNOPSIS
2.3.1.2 (L1) Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only)

.DESCRIPTION
This policy setting determines whether the Guest account is enabled or disabled. The Guest account allows unauthenticated network users to gain access to the system.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountsEnableGuestAccount

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.1.2    L1    Ensure 'Accounts: Guest account status' is set to 'Disabled'... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountsEnableGuestAccount {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        $Number = '2.3.1.2'
        $Level = 'L1'
        
        $Title= "Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only)"
        $Source = 'FixMe'
        # Get the current value of the setting
        $EntryName = "EnableGuestAccount"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SystemAccessPolicyName" -GPResult $GPResult -Results "ComputerResults"
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Result.Setting) {
            $Result.SetCorrectly = $false
        } elseif ($Result.Setting -eq $false) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}


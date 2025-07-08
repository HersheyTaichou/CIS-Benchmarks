<#
.SYNOPSIS
2.3.1.1 (L1) Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'

.DESCRIPTION
This policy setting prevents users from adding new Microsoft accounts on this computer.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountsNoConnectedUser

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.1.1    L1    Ensure 'Accounts: Block Microsoft accounts' is set to 'Users... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountsNoConnectedUser {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $Number = '2.3.1.1'
        $Level = 'L1'
        
        $Title= "Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\NoConnectedUser"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        # Check if the domain setting meets the CIS Benchmark
        if ($Result.Entry.SettingNumber -eq 3) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Result.Setting = $Result.Entry.Display.DisplayString
            return $Result
    }
}


<#
.SYNOPSIS
2.3.1.3 (L1) Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether local accounts that are not password protected can be used to log on from locations other than the physical computer console.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountsLimitBlankPasswordUse

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.1.3    L1    Ensure 'Accounts: Limit local account use of blank passwords... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AccountsLimitBlankPasswordUse {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\LimitBlankPasswordUse"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.SetCorrectly = [int]$Result.Entry.SettingNumber
    }

    end {
        $Number = '2.3.1.3'
        $Level = 'L1'
        
        $Title= "Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled'"
        $Source = 'FixMe'
        $Result.Setting = $Result.Entry.Display.DisplayString
            return $Result
    }
}


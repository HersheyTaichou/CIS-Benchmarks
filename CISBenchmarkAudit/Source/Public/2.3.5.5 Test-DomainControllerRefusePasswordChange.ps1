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
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RefusePasswordChange"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
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
        $Number = '2.3.5.5'
        $Level = 'L1'
        $Result.Profile = "Domain Controller"
        $Title= "Ensure 'Domain controller: Refuse machine account password changes' is set to 'Disabled' (DC only)"
        $Source = 'FixMe'
        return $Result
    }
}

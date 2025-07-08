<#
.SYNOPSIS
2.3.6.5 (L1) Ensure 'Domain member: Maximum machine account password age' is set to '30 or fewer days, but not 0'

.DESCRIPTION
This policy setting determines the maximum allowable age for a computer account password.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainMemberMaximumPasswordAge

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.6.5    L1    Ensure 'Domain member: Maximum machine account password age'... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainMemberMaximumPasswordAge {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\MaximumPasswordAge"
        $Number = '2.3.6.5'
        $Level = 'L1'
        
        $Title= "Ensure 'Domain member: Maximum machine account password age' is set to '30 or fewer days, but not 0'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingNumber
        if (($Result.Setting -le 30) -and ($Result.Setting -gt 0)) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

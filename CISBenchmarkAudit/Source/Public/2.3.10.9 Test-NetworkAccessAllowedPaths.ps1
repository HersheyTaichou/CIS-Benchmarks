<#
.SYNOPSIS
2.3.10.10 (L1) Ensure 'Network access: Restrict anonymous access to Named Pipes and Shares' is set to 'Enabled'

.DESCRIPTION
When enabled, this policy setting restricts anonymous access to only those shares and pipes that are named in the "Network access: Named pipes that can be accessed anonymously" and "Network access: Shares that can be accessed anonymously" settings.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessRestrictNullSessAccess

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.10  L1    Ensure 'Network access: Restrict anonymous access to Named P... Group Policy Settings     True        


.NOTES
General notes
#>
function Test-NetworkAccessRestrictNullSessAccess {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\RestrictNullSessAccess"
        $Number = '2.3.10.10'
        $Level = 'L1'
        
        $Title= "Ensure 'Network access: Restrict anonymous access to Named Pipes and Shares' is set to 'Enabled'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry.KeyName) {
            $Result.SetCorrectly = $Result.Setting
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

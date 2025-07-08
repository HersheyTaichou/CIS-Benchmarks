<#
.SYNOPSIS
2.3.10.13 (L1) Ensure 'Network access: Sharing and security model for local accounts' is set to 'Classic - local users authenticate as themselves'

.DESCRIPTION
This policy setting determines how network logons that use local accounts are authenticated.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessForceGuest

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.13  L1    Ensure 'Network access: Sharing and security model for local... Group Policy Settings     True        


.NOTES
General notes
#>
function Test-NetworkAccessForceGuest {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\ForceGuest"
        $Number = '2.3.10.13'
        $Level = 'L1'
        
        $Title= "Ensure 'Network access: Sharing and security model for local accounts' is set to 'Classic - local users authenticate as themselves'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry) {
            if ($Result.Setting -eq 0) {
                $Result.SetCorrectly = $true
            } else {
                $Result.SetCorrectly = $false
            }
        } else {
            $Result.SetCorrectly = $false
        }
        
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.3.5.1 (L1) Ensure 'Domain controller: Allow server operators to schedule tasks' is set to 'Disabled' (DC only)

.DESCRIPTION
This policy setting determines whether members of the Server Operators group are allowed to submit jobs by means of the AT schedule facility.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainControllerSubmitControl

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.5.1    L1    Ensure 'Domain controller: Allow server operators to schedul... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainControllerSubmitControl {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\SubmitControl"
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
        $Number = '2.3.5.1'
        $Level = 'L1'
        $Result.Profile = "Domain Controller"
        $Title= "Ensure 'Domain controller: Allow server operators to schedule tasks' is set to 'Disabled' (DC only)"
        $Source = 'FixMe'
        return $Result
    }
}

<#
.SYNOPSIS
2.3.13.1 (L1) Ensure 'Shutdown: Allow system to be shut down without having to log on' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether a computer can be shut down when a user is not logged on.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-ShutdownShutdownWithoutLogon

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.13.1   L1    Ensure 'Shutdown: Allow system to be shut down without havin... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-ShutdownShutdownWithoutLogon {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ShutdownWithoutLogon"
        $Result.Number = '2.3.13.1'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Shutdown: Allow system to be shut down without having to log on' is set to 'Disabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry.KeyName) {
            $Result.SetCorrectly = -not($Result.Setting)
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
18.10.57.2.2 (L1) Ensure 'Do not allow passwords to be saved' is set to 'Enabled'

.DESCRIPTION
This policy setting helps prevent Remote Desktop clients from saving passwords on a computer.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE


Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-RemoteDesktopConnectionClientDisablePasswordSaving {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Do not allow passwords to be saved"
        $Result = [CISBenchmark]::new()
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
            $Result.Number = '18.10.57.2.3'
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
            $Result.Number = '18.10.57.2.2'
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
            $Result.Number = '18.10.57.2.2'
        }
        $Result.Title = "Ensure 'Do not allow passwords to be saved' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.State
        if ($Result.Setting -eq "Enabled") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}
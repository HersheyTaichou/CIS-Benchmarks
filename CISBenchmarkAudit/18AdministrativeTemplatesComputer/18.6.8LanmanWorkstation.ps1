<#
.SYNOPSIS
18.6.8.1 (L1) Ensure 'Enable insecure guest logons' is set to 'Disabled'

.DESCRIPTION
This policy setting determines if the SMB client will allow insecure guest logons to an SMB server.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-LanmanWorkstationAllowInsecureGuestAuth

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-LanmanWorkstationAllowInsecureGuestAuth {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Enable insecure guest logons"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.6.8.1'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Enable insecure guest logons' is set to 'Disabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        $Result.Setting = $Result.Entry.State
        if ($Result.Setting -eq "Disabled") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

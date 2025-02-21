<#
.SYNOPSIS
18.10.92.2.1 (L1) Ensure 'Prevent users from modifying settings' is set to 'Enabled'

.DESCRIPTION
This policy setting prevent users from making changes to the Exploit protection settings area in the Windows Security settings.

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
function Test-AppAndBrowserProtectionDisallowExploitProtectionOverride {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Prevent users from modifying settings"
        $Result = [CISBenchmark]::new()
        $Number = '18.10.92.2.1'
        $Level = 'L1'
        
        $Title= "Ensure 'Prevent users from modifying settings' is set to 'Enabled'"
        $Source = 'FixMe'

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

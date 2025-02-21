<#
.SYNOPSIS
18.9.48.1 (L2) Ensure 'Turn off the advertising ID' is set to 'Enabled'

.DESCRIPTION
This policy setting turns off the advertising ID, preventing apps from using the ID for experiences across apps.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserProfilesAdvertisingInfo

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-UserProfilesAdvertisingInfo {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Turn off the advertising ID"
        $Result = [CISBenchmark]::new()
        $Number = '18.9.48.1'
        $Level = 'L2'
        
        $Title= "Ensure 'Turn off the advertising ID' is set to 'Enabled'"
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

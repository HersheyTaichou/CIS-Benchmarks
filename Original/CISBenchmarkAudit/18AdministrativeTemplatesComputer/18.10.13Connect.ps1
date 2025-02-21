<#
.SYNOPSIS
18.10.13.1 (L1) Ensure 'Require pin for pairing' is set to 'Enabled: First Time' OR 'Enabled: Always'

.DESCRIPTION
This policy setting controls whether or not a PIN is required for pairing to a wireless display device.

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
function Test-ConnectRequirePinForPairing {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Require pin for pairing"
        $Result = [CISBenchmark]::new()
        $Number = '18.10.13.1'
        $Level = 'L1'
        
        $Title= "Ensure 'Require pin for pairing' is set to 'Enabled: First Time' OR 'Enabled: Always'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        
        # First Time shows up as "NotConfigured" in the XML file.
        if ($Result.Entry.DropDownList.State -eq "NotConfigured" -and $Result.Entry.State -eq "Enabled") {
            $Result.Setting = "First Time"
            $Result.SetCorrectly = $true
        } elseif ($Result.Entry.DropDownList.Value.Name -eq "Always" -and $Result.Entry.State -eq "Enabled") {
            $Result.Setting = $Result.Entry.DropDownList.Value.Name
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

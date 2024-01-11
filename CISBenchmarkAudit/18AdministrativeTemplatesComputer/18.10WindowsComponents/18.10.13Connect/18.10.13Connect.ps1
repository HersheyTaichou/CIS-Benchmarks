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
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Require pin for pairing"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.10.13.1'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Require pin for pairing' is set to 'Enabled: First Time' OR 'Enabled: Always'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
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

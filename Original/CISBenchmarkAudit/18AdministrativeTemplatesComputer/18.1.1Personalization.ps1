<#
.SYNOPSIS
18.1.1.1 (L1) Ensure 'Prevent enabling lock screen camera' is set to 'Enabled'

.DESCRIPTION
Disables the lock screen camera toggle switch in PC Settings and prevents a camera from being invoked on the lock screen.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PersonalizationPreventEnablingLockScreenCamera

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
18.1.1.1   L1    Ensure 'Prevent enabling lock screen camera' is set to 'Enab... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-PersonalizationPreventEnablingLockScreenCamera {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
              $EntryName = "Prevent enabling lock screen camera"
        $Result = [CISBenchmark]::new()
        $Result.Number = "18.1.1.1"
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Prevent enabling lock screen camera' is set to 'Enabled'"
		$Result.Source = "Group Policy Settings"

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

<#
.SYNOPSIS
18.1.1.2 (L1) Ensure 'Prevent enabling lock screen slide show' is set to 'Enabled'

.DESCRIPTION
Disables the lock screen slide show settings in PC Settings and prevents a slide show from playing on the lock screen.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PersonalizationPreventenablinglockscreenslideshow

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
18.1.1.2   L1    Ensure 'Prevent enabling lock screen slide show' is set to '... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-PersonalizationPreventEnablingLockScreenSlideshow {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
              $EntryName = "Prevent enabling lock screen slide show"
        $Result = [CISBenchmark]::new()
        $Result.Number = "18.1.1.2"
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Prevent enabling lock screen slide show' is set to 'Enabled'"
		$Result.Source = "Group Policy Settings"

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
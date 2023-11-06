<#
.SYNOPSIS
18.1.1.1 (L1) Ensure 'Prevent enabling lock screen camera' is set to 'Enabled'

.DESCRIPTION
Disables the lock screen camera toggle switch in PC Settings and prevents a camera from being invoked on the lock screen.

.EXAMPLE
Test-PersonalizationPreventEnablingLockScreenCamera

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  

.NOTES
General notes
#>
function Test-PersonalizationPreventEnablingLockScreenCamera {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Prevent enabling lock screen camera"
        $Result = [CISBenchmark]::new()
        $Result.Number = "18.1.1.1"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Prevent enabling lock screen camera' is set to 'Enabled'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
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
        
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
18.1.1.2 (L1) Ensure 'Prevent enabling lock screen slide show' is set to 'Enabled'

.DESCRIPTION
Disables the lock screen slide show settings in PC Settings and prevents a slide show from playing on the lock screen.

.EXAMPLE
Test-PersonalizationPreventenablinglockscreenslideshow

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  

.NOTES
General notes
#>
function Test-PersonalizationPreventEnablingLockScreenSlideshow {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Prevent enabling lock screen slide show"
        $Result = [CISBenchmark]::new()
        $Result.Number = "18.1.1.2"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Prevent enabling lock screen slide show' is set to 'Enabled'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
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
        
        $Return += $Result

        Return $Return
    }
}
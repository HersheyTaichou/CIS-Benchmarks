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
    param ()

    begin {
        $Return = @()
        $EntryName = "Prevent enabling lock screen camera"
        $RecommendationNumber = '18.1.1.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Prevent enabling lock screen camera' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name"
    }

    process {
        $Setting = $Entry.State
        if ($Setting -eq "Enabled") {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

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
    param ()

    begin {
        $Return = @()
        $EntryName = "Prevent enabling lock screen slide show"
        $RecommendationNumber = '18.1.1.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Prevent enabling lock screen slide show' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name"
    }

    process {
        $Setting = $Entry.State
        if ($Setting -eq "Enabled") {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}
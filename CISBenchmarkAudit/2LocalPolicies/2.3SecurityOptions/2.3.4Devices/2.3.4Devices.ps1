function Test-DevicesAllocateDASD {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AllocateDASD"
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
        [string]$Setting = $Entry.Display.DisplayString
    }

    process {
        if ($Setting -eq "Administrators") {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $RecommendationNumber = '2.3.4.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Devices: Allowed to format and eject removable media' is set to 'Administrators'"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
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

function Test-DevicesAddPrinterDrivers {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

         # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers\AddPrinterDrivers"
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
        [bool]$Setting = [int]$Entry.SettingNumber
    }

    process {
        if ($Setting) {
            $Pass = $Setting
        } else {
            $Pass = $false
        }
    }

    end {
        $RecommendationNumber = '2.3.4.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Devices: Prevent users from installing printer drivers' is set to 'Enabled'"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
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
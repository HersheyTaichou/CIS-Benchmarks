function Test-DevicesAllocateDASD {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AllocateDASD"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.KeyName -eq $EntryName) {
                    [string]$Setting = $Entry.Display.DisplayString
                }
            }
        }
    }

    process {
        if ($Setting = "Administrators") {
            $result = $true
        } else {
            $result = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.4.1'
            'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Devices: Allowed to format and eject removable media' is set to 'Administrators'"
            'Source' = 'Group Policy Settings'
            'Result'= $result
            'Setting' = $Setting
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

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers\AddPrinterDrivers"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.KeyName -eq $EntryName) {
                    [bool]$Setting = $Entry.SettingNumber
                }
            }
        }
    }

    process {
        $result = $Setting
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.4.2'
            'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Devices: Prevent users from installing printer drivers' is set to 'Enabled'"
            'Source' = 'Group Policy Settings'
            'Result'= $result
            'Setting' = $Setting
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}
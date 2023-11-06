<#
.SYNOPSIS
2.3.4.1 (L1) Ensure 'Devices: Allowed to format and eject removable media' is set to 'Administrators'

.DESCRIPTION
This policy setting determines who is allowed to format and eject removable NTFS media.

.EXAMPLE
Test-DevicesAllocateDASD

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.4.1   (L1) Ensure 'Devices: Allowed to format and eject removable media' is set to 'Administrators'       Group Policy Settings     True    

.NOTES
General notes
#>
function Test-DevicesAllocateDASD {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AllocateDASD"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
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
2.3.4.2 (L1) Ensure 'Devices: Prevent users from installing printer drivers' is set to 'Enabled'

.DESCRIPTION
For a computer to print to a shared printer, the driver for that shared printer must be installed on the local computer. This security setting determines who is allowed to install a printer driver as part of connecting to a shared printer.

.EXAMPLE
Test-DevicesAddPrinterDrivers

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.4.2   (L1) Ensure 'Devices: Prevent users from installing printer drivers' is set to 'Enabled'            Group Policy Settings     True    

.NOTES
General notes
#>
function Test-DevicesAddPrinterDrivers {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()

         # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers\AddPrinterDrivers"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
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
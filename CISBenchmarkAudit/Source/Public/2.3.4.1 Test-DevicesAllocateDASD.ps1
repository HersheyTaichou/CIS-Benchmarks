<#
.SYNOPSIS
2.3.4.1 (L1) Ensure 'Devices: Allowed to format and eject removable media' is set to 'Administrators'

.DESCRIPTION
This policy setting determines who is allowed to format and eject removable NTFS media.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DevicesAllocateDASD

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.4.1    L1    Ensure 'Devices: Allowed to format and eject removable media... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DevicesAllocateDASD {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AllocateDASD"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
        [string]$Result.Setting = $Result.Entry.Display.DisplayString
    }

    process {
        if ($Result.Setting -eq "Administrators") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Number = '2.3.4.1'
        $Level = 'L1'
        
        $Title= "Ensure 'Devices: Allowed to format and eject removable media' is set to 'Administrators'"
        $Source = 'FixMe'
        return $Result
    }
}

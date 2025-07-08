<#
.SYNOPSIS
2.3.7.9 (L1) Ensure 'Interactive logon: Smart card removal behavior' is set to 'Lock Workstation' or higher

.DESCRIPTION
This policy setting determines what happens when the smart card for a logged-on user is removed from the smart card reader.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-InteractiveLogonScRemoveOption

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.7.9    L1    Ensure 'Interactive logon: Smart card removal behavior' is s... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-InteractiveLogonScRemoveOption {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\ScRemoveOption"
        $Number = '2.3.7.9'
        $Level = 'L1'
        
        $Title= "Ensure 'Interactive logon: Smart card removal behavior' is set to 'Lock Workstation' or higher"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.Display.DisplayString
        if ([int]$Result.Entry.SettingString -ge 1) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

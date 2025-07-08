<#
.SYNOPSIS
2.3.17.3 (L1) Ensure 'User Account Control: Behavior of the elevation prompt for standard users' is set to 'Automatically deny elevation requests'

.DESCRIPTION
This policy setting controls the behavior of the elevation prompt for standard users.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserAccountControlConsentPromptBehaviorUser

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.17.3   L1    Ensure 'User Account Control: Behavior of the elevation prom... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserAccountControlConsentPromptBehaviorUser {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorUser"
        $Number = '2.3.17.3'
        $Level = 'L1'
        
        $Title= "Ensure 'User Account Control: Behavior of the elevation prompt for standard users' is set to 'Automatically deny elevation requests'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.Display.DisplayString
        if ($Result.Entry.KeyName) {
            if ($Result.Entry.SettingNumber -eq 0) {
                $Result.SetCorrectly = $true
            }
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

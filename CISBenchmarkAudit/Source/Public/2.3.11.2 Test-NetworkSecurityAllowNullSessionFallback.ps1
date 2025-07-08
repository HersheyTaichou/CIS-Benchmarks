<#
.SYNOPSIS
2.3.11.2 (L1) Ensure 'Network security: Allow LocalSystem NULL session fallback' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether NTLM is allowed to fall back to a NULL session when used with LocalSystem.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkSecurityAllowNullSessionFallback

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.11.2   L1    Ensure 'Network security: Allow LocalSystem NULL session fal... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkSecurityAllowNullSessionFallback {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0\allownullsessionfallback"
        $Number = '2.3.11.2'
        $Level = 'L1'
        
        $Title= "Ensure 'Network security: Allow LocalSystem NULL session fallback' is set to 'Disabled'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry.KeyName) {
            $Result.SetCorrectly = -not($Result.Setting)
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

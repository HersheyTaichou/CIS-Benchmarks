<#
.SYNOPSIS
2.3.7.7 (L1) Ensure 'Interactive logon: Prompt user to change password before expiration' is set to 'between 5 and 14 days'

.DESCRIPTION
This policy setting determines how far in advance users are warned that their password will expire.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-InteractiveLogonPasswordExpiryWarning

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.7.7    L1    Ensure 'Interactive logon: Prompt user to change password be... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-InteractiveLogonPasswordExpiryWarning {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\PasswordExpiryWarning"
        $Number = '2.3.7.7'
        $Level = 'L1'
        
        $Title= "Ensure 'Interactive logon: Prompt user to change password before expiration' is set to 'between 5 and 14 days'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingNumber
        if (($Result.Setting -ge 5) -and ($Result.Setting -le 14)) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

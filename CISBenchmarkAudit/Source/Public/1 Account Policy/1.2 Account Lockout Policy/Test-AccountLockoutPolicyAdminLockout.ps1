<#
.SYNOPSIS
1.2.3 (L1) Ensure 'Allow Administrator account lockout' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether the built-in Administrator account is subject to the following Account Lockout Policy settings: Account lockout duration, Account lockout threshold, and Reset account lockout counter.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountLockoutPolicyAdminLockout

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.2.4      L1    Ensure 'Allow Administrator account lockout' is set to 'Enab... Group Policy Settings     True

.NOTES
General notes
#>
function Test-AccountLockoutPolicyAdminLockout {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Return = [CISBenchmark]::new()
        $Return.Number = '1.2.3'
        $Return.Level = "L1"
        $Return.Profile = "Member Server"
        $Return.Title = "Ensure 'Allow Administrator account lockout' is set to 'Enabled'"
        $Return.Source = 'Group Policy Settings'
        $EntryName = "AllowAdministratorLockout"
        $Return.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
        $Return.Setting = [System.Convert]::ToBoolean($Return.Entry.SettingBoolean)
    }

    process {
        if ($Return.Setting) {
            $Return.SetCorrectly = $true
        } else {
            $Return.SetCorrectly = $false
        }
    }

    end {
        return $Return
    }
}

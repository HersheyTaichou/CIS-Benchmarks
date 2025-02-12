<#
.SYNOPSIS
1.1.6 (L1) Ensure 'Relax minimum password length limits' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether the minimum password length setting can be increased beyond the legacy limit of 14 characters.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PasswordPolicyRelaxMinimumPasswordLengthLimits

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.1.6      L1    Ensure 'Relax minimum password length limits' is set to 'Ena... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-PasswordPolicyRelaxMinimumPasswordLengthLimits {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType)
    )

    begin {
        $Return = @()
        $Number = "1.1.6"
        $Level = "L1"
        $Title = "Ensure 'Relax minimum password length limits' is set to 'Enabled'"
        $Setting = [bool](Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\" -Name "SAM:RelaxMinimumPasswordLengthLimits").'SAM:RelaxMinimumPasswordLengthLimits'
    }

    process {
        $Return += [CISBenchmark]::new(@{
            'Number' = $Number
            'Level' = $Level
            'Profile' = $ProductType.Profile
            'Title' = $Title
            'Source' = "Secedit"
            'Setting' = $Setting
            'SetCorrectly' = $Setting
        })
    }

    end {
        return $Return
    }
}

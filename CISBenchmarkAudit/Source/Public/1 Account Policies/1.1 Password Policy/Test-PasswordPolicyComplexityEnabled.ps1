<#
.SYNOPSIS
1.1.5 (L1) Ensure 'Password must meet complexity requirements' is set to 'Enabled'

.DESCRIPTION
This policy setting checks all new passwords to ensure that they meet basic requirements for strong passwords.

When this policy is enabled, passwords must meet the following minimum requirements:
• Not contain the user's account name or parts of the user's full name that exceed two consecutive characters
• Be at least six characters in length
• Contain characters from three of the following categories:
    o English uppercase characters (A through Z)
    o English lowercase characters (a through z)
    o Base 10 digits (0 through 9)
    o Non-alphabetic characters (for example, !, $, #, %)
    o A catch-all category of any Unicode character that does not fall under the previous four categories. This fifth category can be regionally specific.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PasswordPolicyComplexityEnabled

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.1.5      L1    Ensure 'Password must meet complexity requirements' is set t... Group Policy Settings     True
1.1.5      L1    Ensure 'Password must meet complexity requirements' is set t... Test Policy Fine Grain... True

.NOTES
General notes
#>
function Test-PasswordPolicyComplexityEnabled {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][string]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Return = @()
        $Number = "1.1.5"
        $Level = "L1"
        $Title = "Ensure 'Password must meet complexity requirements' is set to 'Enabled'"
        $Setting = [bool]$SecEditReport.'System Access'.PasswordComplexity
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

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType.Number -eq 2) {
            try {
                $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            }
            catch {
                Write-Warning "Unable to review Fine Grained Password Policies."
            }
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $Return += [CISBenchmark]::new(@{
                    'Number' = $Number
                    'Level' = $Level
                    'Profile' = $ProductType.Profile
                    'Title' = $Title
                    'Source' = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                    'Setting' = [bool]$FGPasswordPolicy.ComplexityEnabled
                    'SetCorrectly' = [bool]$FGPasswordPolicy.ComplexityEnabled
                    'Entry' = $FGPasswordPolicy
                })
            }
        }
    }

    end {
        return $Return
    }
}

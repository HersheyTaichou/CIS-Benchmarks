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
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = "1.1.5"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Password must meet complexity requirements' is set to 'Enabled'"
		$Result.Source = "Group Policy Settings"

        #Find the Password History Size applied to this machine
        $EntryName = "PasswordComplexity"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
        $Result.Setting = [bool]$Result.Entry.SettingBoolean
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Result.Setting) {
            $Result.SetCorrectly = $Result.Setting
        } else {
            $Result.SetCorrectly = $false
        }

        
        $Return += $Result

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $Result = [CISBenchmark]::new()
                $Result.Number = '1.1.5'
                $Result.Level = "L1"
                $Result.Profile = "Domain Controller"
                $Result.Title = "Ensure 'Password must meet complexity requirements' is set to 'Enabled'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                $Result.Setting = $FGPasswordPolicy.ComplexityEnabled

                $Result.SetCorrectly = [bool]$FGPasswordPolicy.ComplexityEnabled
                $Result.Entry = $FGPasswordPolicy

                $Return += $Result
            }
        }
    }

    end {
        return $Return
    }
}

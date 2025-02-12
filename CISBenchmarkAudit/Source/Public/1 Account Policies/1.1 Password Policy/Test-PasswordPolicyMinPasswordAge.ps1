<#
.SYNOPSIS
1.1.3 (L1) Ensure 'Minimum password age' is set to '1 or more day(s)'

.DESCRIPTION
This policy setting determines the number of days that you must use a password before you can change it. The range of values for this policy setting is between 1 and 999 days. (You may also set the value to 0 to allow immediate password changes.) The default value for this setting is 0 days.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PasswordPolicyMinPasswordAge

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.1.3      L1    Ensure 'Minimum password age' is set to '1 or more day(s)'      Group Policy Settings     True        
1.1.3      L1    Ensure 'Minimum password age' is set to '1 or more day(s)'      Test Policy Fine Grain... True        


.NOTES
General notes
#>
function Test-PasswordPolicyMinPasswordAge {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Return = @()
        $Number = "1.1.3"
        $Level = "L1"
        $Title = "Ensure 'Minimum password age' is set to '1 or more day(s)'"
        $Setting = [int]$SecEditReport.'System Access'.MinimumPasswordAge
    }

    process {
        # Check if the current setting meets the CIS Benchmark
        if ($Setting -gt 0) {
            $SetCorrectly = $true
        } else {
            $SetCorrectly = $false
        }

        $Return += [CISBenchmark]::new(@{
            'Number' = $Number
            'Level' = $Level
            'Profile' = $ProductType.Profile
            'Title' = $Title
            'Source' = "Secedit"
            'Setting' = $Setting
            'SetCorrectly' = $SetCorrectly
        })

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType.Number -eq 2) {
            try {
                $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            }
            catch {
                Write-Warning "Unable to review Fine Grained Password Policies."
            }
            $Return += foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                [CISBenchmark]::new(@{
                    'Number' = $Number
                    'Level' = $Level
                    'Profile' = $ProductType.Profile
                    'Title' = $Title
                    'Source' = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                    'Setting' = [int]$FGPasswordPolicy.MinPasswordAge
                    'SetCorrectly' = if ($FGPasswordPolicy.MinPasswordAge -gt (New-TimeSpan -Days 0)) {
                            $true
                        } else {
                            $false
                        }
                    'Entry' = $FGPasswordPolicy
                })
            }
        }
    }

    end {
        return $Return
    }

}

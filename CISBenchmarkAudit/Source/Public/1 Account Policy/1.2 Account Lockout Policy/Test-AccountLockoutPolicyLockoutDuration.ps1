<#
.SYNOPSIS
1.2.1 (L1) Ensure 'Account lockout duration' is set to '15 or more minute(s)'

.DESCRIPTION
This policy setting determines the length of time that must pass before a locked account is unlocked and a user can try to log on again.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountLockoutPolicyLockoutDuration

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.2.1      L1    Ensure 'Account lockout duration' is set to '15 or more minu... Group Policy Settings     True
1.2.1      L1    Ensure 'Account lockout duration' is set to '15 or more minu... Test Policy Fine Grain... True

.NOTES
General notes
#>
function Test-AccountLockoutPolicyLockoutDuration {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    begin {
        $Return = @()
        $Number = '1.2.1'
        $Level = 'L1'
        $Title= "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
        $Setting = [bool]$SecEditReport.'System Access'.LockoutDuration
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -ge "15") {
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
                    'Setting' = [int]$FGPasswordPolicy.LockoutDuration
                    'SetCorrectly' = if ($FGPasswordPolicy.LockoutDuration -ge (New-TimeSpan -Minutes 15)) {
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

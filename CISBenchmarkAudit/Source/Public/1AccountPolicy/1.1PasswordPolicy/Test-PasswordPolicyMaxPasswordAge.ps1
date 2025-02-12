<#
.SYNOPSIS
1.1.2 (L1) Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'

.DESCRIPTION
This policy setting defines how long a user can use their password before it expires.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PasswordPolicyMaxPasswordAge

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.1.2      L1    Ensure 'Maximum password age' is set to '365 or fewer days, ... Group Policy Settings     True        
1.1.2      L1    Ensure 'Maximum password age' is set to '365 or fewer days, ... Test Policy Fine Grain... True        

.NOTES
General notes
#>
function Test-PasswordPolicyMaxPasswordAge {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][string]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $Number = "1.1.2"
        $Level = "L1"
        $Title = "Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'"
        $Setting = [int]$SeceditReport.'System Access'.MaximumPasswordAge
    }

    process {
        # Check if the current setting meets the CIS Benchmark
        if ($Setting -gt "0" -and $Setting -le "365") {
            $SetCorrectly = $true
        } else {
            $SetCorrectly = $false
        }

        $Return += [CISBenchmark]::new(@{
            'Number' = $Number
            'Level' = $Level
            'Profile' = $ProductType
            'Title' = $Title
            'Source' = "Secedit"
            'Setting' = $Setting
            'SetCorrectly' = $SetCorrectly
        })

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            try {
                $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            }
            catch {
                Write-Warning "Unable to review Fine Grained Password Policies."
            }
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $Setting = [int]$FGPasswordPolicy.MaxPasswordAge
                
                $Return += [CISBenchmark]::new(@{
                    'Number' = $Number
                    'Level' = $Level
                    'Profile' = $ProductType
                    'Title' = $Title
                    'Source' = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                    'Setting' = $Setting
                    'SetCorrectly' = if ($Setting -gt (New-TimeSpan -Days 0) -and $Setting -le (New-TimeSpan -Days 365)) {
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

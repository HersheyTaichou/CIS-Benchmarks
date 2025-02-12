<#
.SYNOPSIS
1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'

.DESCRIPTION
This policy setting determines the number of renewed, unique passwords that have to be associated with a user account before you can reuse an old password. The value for this policy setting must be between 0 and 24 passwords. The default value for stand-alone systems is 0 passwords, but the default setting when joined to a domain is 24 passwords. To maintain the effectiveness of this policy setting, use the Minimum password age setting to prevent users from repeatedly changing their password.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PasswordPolicyPasswordHistory

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.1.1      L1    Ensure 'Enforce password history' is set to '24 or more pass... Group Policy Settings     True        
1.1.1      L1    Ensure 'Enforce password history' is set to '24 or more pass... Test Policy Fine Grain... True        

.NOTES
General notes
#>
function Test-PasswordPolicyPasswordHistory {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Return = @()
        $Number = "1.1.1"
        $Level = "L1"
        $Title = "Ensure 'Enforce password history' is set to '24 or more password(s)'"
        $Setting = [int]$SecEditReport.'System Access'.PasswordHistorySize
    }

    process {
        if ($Setting -ge 24) {
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
                $Setting = 
                [CISBenchmark]::new(@{
                    'Number' = $Number
                    'Level' = $Level
                    'Profile' = $ProductType.Profile
                    'Title' = $Title
                    'Source' = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                    'Setting' = [int]$FGPasswordPolicy.PasswordHistoryCount
                    'SetCorrectly' = if ($FGPasswordPolicy.PasswordHistoryCount -ge 24) {
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

<#
.SYNOPSIS
1.2.1 (L1) Ensure 'Account lockout duration' is set to '15 or more minute(s)'

.DESCRIPTION
This policy setting determines the length of time that must pass before a locked account is unlocked and a user can try to log on again.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.EXAMPLE
Test-AccountLockoutPolicyLockoutDuration

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.2.1     (L1) Ensure 'Account lockout duration' is set to '15 or more minute(s)'                             Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AccountLockoutPolicyLockoutDuration {
    [CmdletBinding()]
    param ()
    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.2.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "LockoutDuration"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name"
        $Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -ge "15") {
            $Pass = $true
        } else {
            $Pass = $false
        }

        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                if ($FGPasswordPolicy.LockoutDuration -ge (New-TimeSpan -Minutes 15)) {
                    $Pass = $true
                } else {
                    $Pass = $false
                }

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'Number' = $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'Name'= $RecommendationName
                    'Source' = $Source
                    'Pass'= $Pass
                    'Setting' = [bool]$FGPasswordPolicy.LockoutDuration
                    'Entry' = $FGPasswordPolicy
                }
                $Properties.PSTypeNames.Add('psCISBenchmark')
                $Return += $Properties
            }
        }
    }

    end {
        return $Return
    }
}

<#
.SYNOPSIS
1.2.2 (L1) Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'

.DESCRIPTION
This policy setting determines the number of failed logon attempts before the account is locked.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.EXAMPLE
Test-AccountLockoutPolicyLockoutThreshold

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.2.2     (L1) Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'  Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AccountLockoutPolicyLockoutThreshold {
    [CmdletBinding()]
    param ()
    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.2.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "LockoutBadCount"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name"
        $Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -gt "0" -and $Setting -le "5") {
            $Pass = $true
        } else {
            $Pass = $false
        }

        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                if ($FGPasswordPolicy.LockoutThreshold -gt "0" -and $FGPasswordPolicy.LockoutThreshold -le "5") {
                    $Pass = $true
                } else {
                    $Pass = $false
                }

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'Number' = $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'Name'= $RecommendationName
                    'Source' = $Source
                    'Pass'= $Pass
                    'Setting' = [bool]$FGPasswordPolicy.LockoutThreshold
                    'Entry' = $FGPasswordPolicy
                }
                $Properties.PSTypeNames.Add('psCISBenchmark')
                $Return += $Properties
            }
        }
    }

    end {
        return $Return
    }
}

<#
.SYNOPSIS
1.2.3 (L1) Ensure 'Allow Administrator account lockout' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether the built-in Administrator account is subject to the following Account Lockout Policy settings: Account lockout duration, Account lockout threshold, and Reset account lockout counter.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.EXAMPLE
Test-AccountLockoutPolicyAdminLockout

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.2.3     (L1) Ensure 'Allow Administrator account lockout' is set to 'Enabled'                               Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AccountLockoutPolicyAdminLockout {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $RecommendationNumber = '1.2.3'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Allow Administrator account lockout' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        #Find the maximum password age applied to this machine
        $EntryName = "AllowAdministratorLockout"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name"
        [string]$Setting = $Entry.SettingBoolean
    }

    process {
        if ($Setting -eq "true") {
            $Pass = $true
            $Setting = $true
        } elseif ($Setting -eq "false") {
            $Pass = $false
            $Setting = $false
        } else {
            $Pass = $false
            $Setting = ""
        }

        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties
    }

    end {
        return $Return
    }
}

<#
.SYNOPSIS
1.2.4 (L1) Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'

.DESCRIPTION
This policy setting determines the length of time before the Account lockout threshold resets to zero.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.EXAMPLE
Test-AccountLockoutPolicyResetLockoutCount

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.2.4     (L1) Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'                  Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AccountLockoutPolicyResetLockoutCount {
    [CmdletBinding()]
    param ()
    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.2.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "ResetLockoutCount"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name"
        $Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -ge "15") {
            $Pass = $true
        } else {
            $Pass = $false
        }

        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                if ($FGPasswordPolicy.LockoutObservationWindow -ge (New-TimeSpan -Minutes 15)) {
                    $Pass = $true
                } else {
                    $Pass = $false
                }

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'Number' = $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'Name'= $RecommendationName
                    'Source' = $Source
                    'Pass'= $Pass
                    'Setting' = [bool]$FGPasswordPolicy.LockoutObservationWindow
                    'Entry' = $FGPasswordPolicy
                }
                $Properties.PSTypeNames.Add('psCISBenchmark')
                $Return += $Properties
            }
        }
    }

    end {
        return $Return
    }
}
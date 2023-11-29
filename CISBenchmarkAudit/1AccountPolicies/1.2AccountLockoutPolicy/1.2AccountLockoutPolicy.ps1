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
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    begin {
        
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = "1.2.1"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
		$Result.Source = "Group Policy Settings"

        #Find the Password History Size applied to this machine
        $EntryName = "LockoutDuration"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        $Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Result.Setting -ge "15") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }

        
        $Return += $Result

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $Result = [CISBenchmark]::new()
                $Result.Number = "1.2.1"
                $Result.Level = "L1"
                $Result.Profile = "Domain Controller"
                $Result.Title = "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                if ($FGPasswordPolicy.LockoutDuration -ge (New-TimeSpan -Minutes 15)) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
                $Result.Setting = [bool]$FGPasswordPolicy.LockoutDuration
                $Result.Entry = $FGPasswordPolicy
                $Return += $Result
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

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountLockoutPolicyLockoutThreshold

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.2.2      L1    Ensure 'Account lockout threshold' is set to '5 or fewer inv... Group Policy Settings     True        
1.2.2      L1    Ensure 'Account lockout threshold' is set to '5 or fewer inv... Test Policy Fine Grain... True        

.NOTES
General notes
#>
function Test-AccountLockoutPolicyLockoutThreshold {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = '1.2.2'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'"
        $Result.Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "LockoutBadCount"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        $Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Result.Setting -gt "0" -and $Result.Setting -le "5") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }

        
        $Return += $Result

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $Result = [CISBenchmark]::new()
                $Result.Number = "1.2.2"
                $Result.Level = "L1"
                $Result.Profile = "Domain Controller"
                $Result.Title = "Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                if ($FGPasswordPolicy.LockoutThreshold -gt "0" -and $FGPasswordPolicy.LockoutThreshold -le "5") {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }

                $Result.Setting = [bool]$FGPasswordPolicy.LockoutThreshold
                $Result.Entry = $FGPasswordPolicy
                $Return += $Result
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
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = '1.2.3'
        $Result.Level = "L1"
        $Result.Profile = "Member Server"
        $Result.Title = "Ensure 'Allow Administrator account lockout' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'

        #Find the maximum password age applied to this machine
        $EntryName = "AllowAdministratorLockout"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        [string]$Result.Setting = $Result.Entry.SettingBoolean
    }

    process {
        if ($Result.Setting -eq "true") {
            $Result.SetCorrectly = $true
            $Result.Setting = $true
        } elseif ($Result.Setting -eq "false") {
            $Result.SetCorrectly = $false
            $Result.Setting = $false
        } else {
            $Result.SetCorrectly = $false
            $Result.Setting = ""
        }

        
        $Return += $Result
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

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountLockoutPolicyResetLockoutCount

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.2.4      L1    Ensure 'Reset account lockout counter after' is set to '15 o... Group Policy Settings     True        
1.2.4      L1    Ensure 'Reset account lockout counter after' is set to '15 o... Test Policy Fine Grain... True        

.NOTES
General notes
#>
function Test-AccountLockoutPolicyResetLockoutCount {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = "1.2.4"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'"
		$Result.Source = "Group Policy Settings"

        #Find the Password History Size applied to this machine
        $EntryName = "ResetLockoutCount"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        $Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Result.Setting -ge "15") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }

        
        $Return += $Result

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $Result = [CISBenchmark]::new()
                $Result.Number = "1.2.4"
                $Result.Level = "L1"
                $Result.Profile = "Domain Controller"
                $Result.Title = "Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                if ($FGPasswordPolicy.LockoutObservationWindow -ge (New-TimeSpan -Minutes 15)) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
                $Result.Setting = [bool]$FGPasswordPolicy.LockoutObservationWindow
                $Result.Entry = $FGPasswordPolicy
                $Return += $Result
            }
        }
    }

    end {
        return $Return
    }
}
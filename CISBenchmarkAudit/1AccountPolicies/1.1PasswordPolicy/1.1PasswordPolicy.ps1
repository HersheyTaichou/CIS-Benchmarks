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
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = '1.1.1'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Enforce password history' is set to '24 or more password(s)'"
        

        #Find the Password History Size applied to this machine
        $EntryName = "PasswordHistorySize"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        $Result.Setting = [int]$Result.Entry.SettingNumber

        $CISControlInfo = [CISControl]::new()
        if ($CISControl -eq 8) {
            $CISControlInfo.Version = 8
            $CISControlInfo.Safeguard = "5.2 Use Unique Passwords"
            $CISControlInfo.ImplementationGroup = 1
        } elseif ($CISControl -eq 7) {
            $CISControlInfo.Version = 7
            $CISControlInfo.Safeguard = "16.2 Configure Centralized Point of Authentication"
            $CISControlInfo.ImplementationGroup = 2
        }
        $Result.CISControl = $CISControlInfo

    }

    process {
        $Result.Source = 'Group Policy Settings'
        if ($Result.Setting -ge 24) {
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
                $Result.Number = '1.1.1'
                $Result.Level = "L1"
                $Result.Profile = "Domain Controller"
                $Result.Title = "Ensure 'Enforce password history' is set to '24 or more password(s)'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                $Result.Setting = $FGPasswordPolicy.PasswordHistoryCount
                if ($Result.Setting -ge "24") {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }

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
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = '1.1.2'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'"
        $Result.Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "MaximumPasswordAge"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        $Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Result.Setting -gt "0" -and $Result.Setting -le "365") {
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
                $Result.Number = '1.1.2'
                $Result.Level = "L1"
                $Result.Profile = "Domain Controller"
                $Result.Title = "Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                $Result.Setting = $FGPasswordPolicy.MaxPasswordAge
                if ($Result.Setting -gt (New-TimeSpan -Days 0) -and $Result.Setting -le (New-TimeSpan -Days 365)) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }

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
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = "1.1.3"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Minimum password age' is set to '1 or more day(s)'"
		$Result.Source = "Group Policy Settings"

        #Find the Password History Size applied to this machine
        $EntryName = "MinimumPasswordAge"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        $Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Result.Setting -gt 0) {
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
                $Result.Number = '1.1.3'
                $Result.Level = "L1"
                $Result.Profile = "Domain Controller"
                $Result.Title = "Ensure 'Minimum password age' is set to '1 or more day(s)'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                $Result.Setting = $FGPasswordPolicy.MinPasswordAge
                if ($FGPasswordPolicy.MinPasswordAge -gt (New-TimeSpan -Days 0)) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
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
1.1.4 (L1) Ensure 'Minimum password length' is set to '14 or more character(s)'

.DESCRIPTION
This policy setting determines the least number of characters that make up a password for a user account. In enterprise environments, the ideal value for the Minimum password length setting is 14 characters, however you should adjust this value to meet your organization's business requirements.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PasswordPolicyMinPasswordLength

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.1.4      L1    Ensure 'Minimum password length' is set to '14 or more chara... Group Policy Settings     True        
1.1.4      L1    Ensure 'Minimum password length' is set to '14 or more chara... Test Policy Fine Grain... True        

.NOTES
General notes
#>
function Test-PasswordPolicyMinPasswordLength {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = "1.1.4"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Minimum password length' is set to '14 or more character(s)'"
		$Result.Source = "Group Policy Settings"

        #Find the Password History Size applied to this machine
        $EntryName = "MinimumPasswordLength"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        $Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Result.Setting -ge 14) {
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
                $Result.Number = '1.1.4'
                $Result.Level = "L1"
                $Result.Profile = "Domain Controller"
                $Result.Title = "Ensure 'Minimum password length' is set to '14 or more character(s)'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                $Result.Setting = $FGPasswordPolicy.MinPasswordLength
                
                if ($FGPasswordPolicy.MinPasswordLength -ge 14) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
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
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
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
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
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
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $EntryName = "MACHINE\System\CurrentControlSet\Control\SAM\RelaxMinimumPasswordLengthLimits"
        $Result = [CISBenchmark]::new()
        $Result.Number = '1.1.6'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Relax minimum password length limits' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'

        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
        $Result.Setting = [bool]$Result.Entry.SettingNumber
    }

    process {
        if ($Result.Setting) {
            $Result.SetCorrectly = $Result.Setting
        } else {
            $Result.SetCorrectly = $false
        }
        
        $Return += $Result
    }

    end {
        return $Return
    }
}

<#
.SYNOPSIS
1.1.7 (L1) Ensure 'Store passwords using reversible encryption' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether the operating system stores passwords in a way that uses reversible encryption, which provides support for application protocols that require knowledge of the user's password for authentication purposes. Passwords that are stored with reversible encryption are essentially the same as plaintext versions of the passwords.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PasswordPolicyReversibleEncryption

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.1.7      L1    Ensure 'Store passwords using reversible encryption' is set ... Group Policy Settings     True        
1.1.7      L1    Ensure 'Store passwords using reversible encryption' is set ... Test Policy Fine Grain... True        

.NOTES
General notes
#>
function Test-PasswordPolicyReversibleEncryption {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = "1.1.7"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Store passwords using reversible encryption' is set to 'Disabled'"
        $Result.Source = "Group Policy Settings"

        #Find the Password History Size applied to this machine
        $EntryName = "ClearTextPassword"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.SettingBoolean)
        $Result.SetCorrectly = -not($Result.Setting)

        
        $Return += $Result

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $Result = [CISBenchmark]::new()
                $Result.Number = '1.1.7'
                $Result.Level = "L1"
                $Result.Profile = "Domain Controller"
                $Result.Title = "Ensure 'Store passwords using reversible encryption' is set to 'Disabled'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                $Result.Setting = $FGPasswordPolicy.ReversibleEncryptionEnabled
                
                $Result.SetCorrectly = -not([bool]$FGPasswordPolicy.ReversibleEncryptionEnabled)
                $Result.Entry = $FGPasswordPolicy

                $Return += $Result
            }
        }
    }

    end {
        return $Return
    }
}

<#
.SYNOPSIS
1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'

.DESCRIPTION
This policy setting determines the number of renewed, unique passwords that have to be associated with a user account before you can reuse an old password. The value for this policy setting must be between 0 and 24 passwords. The default value for stand-alone systems is 0 passwords, but the default setting when joined to a domain is 24 passwords. To maintain the effectiveness of this policy setting, use the Minimum password age setting to prevent users from repeatedly changing their password.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.EXAMPLE
Test-PasswordPolicyPasswordHistory

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.1.1     (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'                           Group Policy Settings     True    
1.1.1     (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'                           Test Policy Fine Grain... True

.NOTES
General notes
#>
function Test-PasswordPolicyPasswordHistory {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $GPTest = [CISBenchmark]::new()
        $GPTest.Number = '1.1.1'
        $GPTest.Level = "L1"
        if ($ProductType -eq 1) {
            $GPTest.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $GPTest.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $GPTest.Profile = "Member Server"
        }
        $GPTest.Title = "Ensure 'Enforce password history' is set to '24 or more password(s)'"
        

        #Find the Password History Size applied to this machine
        $EntryName = "PasswordHistorySize"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        $GPTest.Setting = [int]$Entry.SettingNumber
    }

    process {
        $GPTest.Source = 'Group Policy Settings'
        if ($GPTest.Setting -ge 24) {
            $GPTest.SetCorrectly = $true
        } else {
            $GPTest.SetCorrectly = $false
        }

        $GPTest.Entry = $Entry
        $Return += $GPTest

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $FGPPTest = [CISBenchmark]::new()
                $FGPPTest.Number = '1.1.1'
                $FGPPTest.Level = "L1"
                $FGPPTest.Profile = "Domain Controller"
                $FGPPTest.Title = "Ensure 'Enforce password history' is set to '24 or more password(s)'"
                $FGPPTest.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                $FGPPTest.Setting = $FGPasswordPolicy.PasswordHistoryCount
                if ($FGPPTest.Setting -ge "24") {
                    $FGPPTest.SetCorrectly = $true
                } else {
                    $FGPPTest.SetCorrectly = $false
                }

                $FGPPTest.Entry = $FGPasswordPolicy
                $Return += $FGPPTest
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

.EXAMPLE
Test-PasswordPolicyMaxPasswordAge

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.1.2     (L1) Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'                         Group Policy Settings     True    

.NOTES
General notes
#>
function Test-PasswordPolicyMaxPasswordAge {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $GPTest = [CISBenchmark]::new()
        $GPTest.Number = '1.1.2'
        $GPTest.Level = "L1"
        if ($ProductType -eq 1) {
            $GPTest.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $GPTest.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $GPTest.Profile = "Member Server"
        }
        $GPTest.Title = "Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'"

        #Find the Password History Size applied to this machine
        $EntryName = "MaximumPasswordAge"
        $GPTest.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name"
        $GPTest.Setting = [int]$Entry.SettingNumber
    }

    process {
        $GPTest.Source = 'Group Policy Settings'
        # Check if the GPO setting meets the CIS Benchmark
        if ($GPTest.Setting -gt "0" -and $GPTest.Setting -le "365") {
            $GPTest.SetCorrectly = $true
        } else {
            $GPTest.SetCorrectly = $false
        }

        $Return += $GPTest

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
           $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $FGPPTest = [CISBenchmark]::new()
                $FGPPTest.Number = '1.1.2'
                $FGPPTest.Level = "L1"
                $FGPPTest.Profile = "Domain Controller"
                $FGPPTest.Title = "Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'"
                $FGPPTest.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                $FGPPTest.Setting = $FGPasswordPolicy.PasswordHistoryCount
                if ($FGPPTest.Setting -gt "0" -and $FGPPTest.Setting -le "365") {
                    $FGPPTest.SetCorrectly = $true
                } else {
                    $FGPPTest.SetCorrectly = $false
                }

                $FGPPTest.Entry = $FGPasswordPolicy
                $Return += $FGPPTest
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

.EXAMPLE
Test-PasswordPolicyMinPasswordAge

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.1.3     (L1) Ensure 'Minimum password age' is set to '1 or more day(s)'                                     Group Policy Settings     True    


.NOTES
General notes
#>
function Test-PasswordPolicyMinPasswordAge {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.1.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Minimum password age' is set to '1 or more day(s)'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "MinimumPasswordAge"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        $Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -gt 0) {
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
                if ($FGPasswordPolicy.MinPasswordAge -gt 0) {
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
                    'Setting' = $FGPasswordPolicy.MinPasswordAge
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
1.1.4 (L1) Ensure 'Minimum password length' is set to '14 or more character(s)'

.DESCRIPTION
This policy setting determines the least number of characters that make up a password for a user account. In enterprise environments, the ideal value for the Minimum password length setting is 14 characters, however you should adjust this value to meet your organization's business requirements.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.EXAMPLE
Test-PasswordPolicyMinPasswordLength

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.1.4     (L1) Ensure 'Minimum password length' is set to '14 or more character(s)'                           Group Policy Settings     True    

.NOTES
General notes
#>
function Test-PasswordPolicyMinPasswordLength {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.1.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Minimum password length' is set to '14 or more character(s)'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "MinimumPasswordLength"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        $Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -ge 14) {
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
                if ($FGPasswordPolicy.MinPasswordLength -ge 14) {
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
                    'Setting' = $FGPasswordPolicy.MinPasswordLength
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

.EXAMPLE
Test-PasswordPolicyComplexityEnabled

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.1.5     (L1) Ensure 'Password must meet complexity requirements' is set to 'Enabled'                        Group Policy Settings     True    

.NOTES
General notes
#>
function Test-PasswordPolicyComplexityEnabled {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.1.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Password must meet complexity requirements' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "PasswordComplexity"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        $Setting = [bool]$Entry.SettingBoolean
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting) {
            $Pass = $Setting
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
                $Pass = [bool]$FGPasswordPolicy.ComplexityEnabled

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'Number' = $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'Name'= $RecommendationName
                    'Source' = $Source
                    'Pass'= $Pass
                    'Setting' = [bool]$FGPasswordPolicy.ComplexityEnabled
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
1.1.6 (L1) Ensure 'Relax minimum password length limits' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether the minimum password length setting can be increased beyond the legacy limit of 14 characters.

.EXAMPLE
Test-PasswordPolicyRelaxMinimumPasswordLengthLimits

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.1.6     (L1) Ensure 'Relax minimum password length limits' is set to 'Enabled'                              Group Policy Settings     True    

.NOTES
General notes
#>
function Test-PasswordPolicyRelaxMinimumPasswordLengthLimits {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $EntryName = "MACHINE\System\CurrentControlSet\Control\SAM\RelaxMinimumPasswordLengthLimits"
        $RecommendationNumber = '1.1.6'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Relax minimum password length limits' is set to 'Enabled'"
        $Source = 'Group Policy Settings'
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult
        $Setting = [bool]$Entry.SettingNumber
    }

    process {
        if ($Setting) {
            $Pass = $Setting
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

.EXAMPLE
Test-PasswordPolicyReversibleEncryption

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
1.1.7     (L1) Ensure 'Store passwords using reversible encryption' is set to 'Disabled'                      Group Policy Settings     True    

.NOTES
General notes
#>
function Test-PasswordPolicyReversibleEncryption {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.1.7'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Store passwords using reversible encryption' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "ClearTextPassword"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
        [string]$Setting = $Entry.SettingBoolean
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -eq "false") {
            $Pass = $true
            $Setting = $false
        } else {
            $Pass = $false
            $Setting = $true
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
                $Pass = [bool]$FGPasswordPolicy.ReversibleEncryptionEnabled

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'Number' = $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'Name'= $RecommendationName
                    'Source' = $Source
                    'Pass'= $Pass
                    'Setting' = [bool]$FGPasswordPolicy.ReversibleEncryptionEnabled
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

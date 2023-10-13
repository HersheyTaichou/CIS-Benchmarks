<#
.SYNOPSIS
1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'

.DESCRIPTION
The command checks the applied domain policy and any fine grained
password policies, to ensure they all meet the 24 password history requirement.

.EXAMPLE
Test-PasswordPolicyPasswordHistory

.NOTES
General notes
#>
function Test-PasswordPolicyPasswordHistory {
    [CmdletBinding()]
    param ()

    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.1.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Enforce password history' is set to '24 or more password(s)'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "PasswordHistorySize"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "Account" -KeyName "Name"
        $Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -ge 24) {
            $result = $true
        } else {
            $result = $false
        }

        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                if ($FGPasswordPolicy.PasswordHistoryCount -ge "24") {
                    $Result = $true
                } else {
                    $result = $false
                }

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'RecommendationNumber'= $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'RecommendationName'= $RecommendationName
                    'Source' = $Source
                    'Result'= $result
                    'Setting' = $FGPasswordPolicy.PasswordHistoryCount
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
1.1.2 (L1) Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'

.DESCRIPTION
The command checks the applied domain policy and any fine grained
password policies, to ensure they all meet the maximum password age requirement.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-PasswordPolicyMaxPasswordAge {
    [CmdletBinding()]
    param ()

    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.1.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "MaximumPasswordAge"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "Account" -KeyName "Name"
        $Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -gt "0" -and $Setting -le "365") {
            $result = $true
        } else {
            $result = $false
        }

        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                if ($FGPasswordPolicy.MaxPasswordAge -gt "0" -and $FGPasswordPolicy.MaxPasswordAge -le "365") {
                    $Result = $true
                } else {
                    $result = $false
                }

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'RecommendationNumber'= $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'RecommendationName'= $RecommendationName
                    'Source' = $Source
                    'Result'= $result
                    'Setting' = $FGPasswordPolicy.MaxPasswordAge
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
1.1.3 (L1) Ensure 'Minimum password age' is set to '1 or more day(s)'

.DESCRIPTION
The command checks the applied domain policy and any fine grained
password policies, to ensure they all meet the minimum password age requirement.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-PasswordPolicyMinPasswordAge {
    [CmdletBinding()]
    param ()

    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.1.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Minimum password age' is set to '1 or more day(s)'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "MinimumPasswordAge"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "Account" -KeyName "Name"
        $Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -gt 0) {
            $result = $true
        } else {
            $result = $false
        }

        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
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
                    $Result = $true
                } else {
                    $result = $false
                }

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'RecommendationNumber'= $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'RecommendationName'= $RecommendationName
                    'Source' = $Source
                    'Result'= $result
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
The command checks the applied domain policy and any fine grained
password policies, to ensure they all meet the minimum password length requirement.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-PasswordPolicyMinPasswordLength {
    [CmdletBinding()]
    param ()
    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.1.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Minimum password length' is set to '14 or more character(s)'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "MinimumPasswordLength"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "Account" -KeyName "Name"
        $Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -ge 14) {
            $result = $true
        } else {
            $result = $false
        }

        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
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
                    $Result = $true
                } else {
                    $result = $false
                }

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'RecommendationNumber'= $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'RecommendationName'= $RecommendationName
                    'Source' = $Source
                    'Result'= $result
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
The command checks the applied domain policy and any fine grained
password policies, to ensure they all have complexity enabled.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-PasswordPolicyComplexityEnabled {
    [CmdletBinding()]
    param ()

    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.1.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Password must meet complexity requirements' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "PasswordComplexity"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "Account" -KeyName "Name"
        $Setting = [bool]$Entry.SettingBoolean
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        $result = $Setting

        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $result = [bool]$FGPasswordPolicy.ComplexityEnabled

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'RecommendationNumber'= $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'RecommendationName'= $RecommendationName
                    'Source' = $Source
                    'Result'= $result
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
The command checks the applied domain policy to ensure that the 
relax minimum password length limits setting is enabled for admin accounts.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-PasswordPolicyRelaxMinimumPasswordLengthLimits {
    [CmdletBinding()]
    param ()

    begin {
        $EntryName = "MACHINE\System\CurrentControlSet\Control\SAM\RelaxMinimumPasswordLengthLimits"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "SecurityOptions" -KeyName "KeyName"
        $Setting = [bool]$Entry.SettingNumber
    }

    process {
        $result = $Setting
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '1.1.6'
            'ProfileApplicability' = @("Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Relax minimum password length limits' is set to 'Enabled'"
            'Source' = 'Group Policy Settings'
            'Result'= $result
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
The command checks the applied domain policy and any fine grained
password policies, to ensure they all have reversible encryption turned off.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-PasswordPolicyReversibleEncryption {
    [CmdletBinding()]
    param ()

    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.1.7'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Store passwords using reversible encryption' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "ClearTextPassword"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "Account" -KeyName "Name"
        [string]$Setting = $Entry.SettingBoolean
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -eq "false") {
            $result = $true
            $Setting = $false
        } else {
            $result = $false
            $Setting = $true
        }

        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $result = [bool]$FGPasswordPolicy.ReversibleEncryptionEnabled

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'RecommendationNumber'= $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'RecommendationName'= $RecommendationName
                    'Source' = $Source
                    'Result'= $result
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

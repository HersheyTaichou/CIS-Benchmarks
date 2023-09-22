<#
.SYNOPSIS
1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'

.DESCRIPTION
The command checks the applied domain policy and any fine grained
password policies, to ensure they all meet the 24 password history requirement.

.EXAMPLE
Test-PasswordHistory

.NOTES
General notes
#>
function Test-PasswordHistory {
    [CmdletBinding()]
    param ()

    # Check the product type
    $ProductType = Get-ProductType
    $Return = @()

    if ($ProductType -eq 2) {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    #Find the Password History Size applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "PasswordHistorySize") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -ge "24") {
        $Message = "1.1.1 The GPO password history is set to " + $Setting + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "1.1.1 The GPO password history is set to " + $Setting + " and does not meet the requirement. Increase the policy to 24 or greater."
        Write-Warning $Message
        $result = $false
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.1'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= 'Ensure "Enforce password history" is set to "24 or more password(s)"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.PasswordHistoryCount -ge "24") {
                $Message = "1.1.1 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the Password history set to "+ $FGPasswordPolicy.PasswordHistoryCount + " and does meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
                $Result = $true
            } else {
                $Message = "1.1.1 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the Password history set to " + $FGPasswordPolicy.PasswordHistoryCount + " and does not meet the requirement. Set the policy to 24 or greater."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $false
            }

            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.1.1'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= 'Ensure "Enforce password history" is set to "24 or more password(s)"'
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.PasswordHistoryCount
            }
            $Properties.PSTypeNames.Add('psCISBenchmark')
            $Return += $Properties
        }
    }
    # Return True if everything meets the CIS benchmark, otherwise False
    return $Return
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
function Test-MaxPasswordAge {
    [CmdletBinding()]
    param ()

    # Check the product type
    $ProductType = Get-ProductType
    $Return = @()

    if ($ProductType -eq "2") {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    #Find the maximum password age applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "MaximumPasswordAge") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -gt "0" -and $Setting -le "365") {
        $Message = "1.1.2 The GPO password history is set to " + $Setting + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "1.1.2 The GPO password history is set to " + $Setting + " and does not meet the requirement. Make sure the max password age is greater than 0 and less than or equal to 365."
        Write-Warning $Message
        $result = $false
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.2'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= 'Ensure "Maximum password age" is set to "365 or fewer days, but not 0"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.MaxPasswordAge -gt "0" -and $FGPasswordPolicy.MaxPasswordAge -le "365") {
                $Message = "1.1.2 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the max password age set to " + $FGPasswordPolicy.MaxPasswordAge + " and does meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
                $Result = $true
            } else {
                $Message = "1.1.2 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the max password age set to "+ $FGPasswordPolicy.MaxPasswordAge + " and does not meet the requirement. Make sure the max password age is greater than 0 and less than or equal to 365."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.1.2'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= 'Ensure "Maximum password age" is set to "365 or fewer days, but not 0"'
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.MaxPasswordAge
            }
            $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties
        }
    }
    return $Return
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
function Test-MinPasswordAge {
    [CmdletBinding()]
    param ()

    # Check the product type
    $ProductType = Get-ProductType
    $Return = @()

    if ($ProductType -eq "2") {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Find the minimum password age applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "MinimumPasswordAge") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -gt "0") {
        $Message = "1.1.3 The GPO minimum password age is set to " + $Setting + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "1.1.3 The GPO minimum password age is set to " + $Setting + " and does not meet the requirement. Make sure the minimum password age is greater than 0."
        Write-Warning $Message
        $result = $false
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.3'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= 'Ensure "Minimum password age" is set to "1 or more day(s)"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.MinPasswordAge -gt "0") {
                $Message = "1.1.3 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password age set to " + $FGPasswordPolicy.MaxPasswordAge + " and does meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
                $Result = $true
            } else {
                $Message = "1.1.3 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password age set to "+ $FGPasswordPolicy.MaxPasswordAge + " and does not meet the requirement. Make sure the minimum password age is greater than 0."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.1.3'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= 'Ensure "Minimum password age" is set to "1 or more day(s)"'
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.MaxPasswordAge
            }
            $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties
        }
    }
    return $Return
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
function Test-MinPasswordLength {
    [CmdletBinding()]
    param ()
    # Check the product type
    $ProductType = Get-ProductType
    $Return = @()

    if ($ProductType -eq "2") {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Find the minimum password length applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "MinimumPasswordLength") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -ge "14") {
        $Message = "1.1.4 The GPO minimum password length is set to " + $Setting + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "1.1.4 The GPO minimum password length is set to " + $Setting + " and does not meet the requirement. Make sure the minimum password length is greater than or equal to 14."
        Write-Warning $Message
        $result = $false
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.4'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= 'Ensure "Minimum password length" is set to "14 or more character(s)"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.MinPasswordLength -ge "14") {
                $Message = "1.1.4 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password length set to " + $FGPasswordPolicy.MinPasswordLength + " and does meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
                $Result = $true
            } else {
                $Message = "1.1.4 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password length set to "+ $FGPasswordPolicy.MinPasswordLength + " and does not meet the requirement. Make sure the minimum password length is greater or equal to 14."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.1.4'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= 'Ensure "Minimum password length" is set to "14 or more character(s)"'
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.MinPasswordLength
            }
            $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties
        }
    }
    return $Return
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
function Test-ComplexityEnabled {
    [CmdletBinding()]
    param ()

    # Check the product type
    $ProductType = Get-ProductType
    $Return = @()

    if ($ProductType -eq "2") {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Check if password complexity is enabled on this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "PasswordComplexity") {
                [bool]$Setting = $Entry.SettingBoolean
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting) {
        $Message = "1.1.5 The GPO policy has complexity enabled and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "1.1.5 The GPO policy has complexity disabled and does not meet the requirement."
        Write-Warning $Message
        $result = $false
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.5'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= 'Ensure "Password must meet complexity requirements" is set to "Enabled"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.ComplexityEnabled) {
                $Message = "1.1.5 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has complexity enabled and does meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
                $Result = $true
            } else {
                $Message = "1.1.5 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has complexity disabled and does not meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.1.5'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= 'Ensure "Password must meet complexity requirements" is set to "Enabled"'
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.ComplexityEnabled
            }
            $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties
        }
    }
    return $Return
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
function Test-RelaxMinimumPasswordLengthLimits {
    [CmdletBinding()]
    param ()
    # This setting is required for Level 1 compliance on Windows Server 2022 or greater.
    $PasswordPolicy = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\SAM" -name "RelaxMinimumPasswordLengthLimits"

    # Check if the GPO setting meets the CIS Benchmark
    if ($PasswordPolicy.RelaxMinimumPasswordLengthLimits -eq "1") {
        $Message = "1.1.6 The Relax minimum password length limits is enabled and meets the requirement."
        Write-Verbose $Message
        $result = $true
        [bool]$Setting = $PasswordPolicy.RelaxMinimumPasswordLengthLimits
    } elseif ($PasswordPolicy.RelaxMinimumPasswordLengthLimits -eq "0") {
        $Message = "1.1.6 The Relax minimum password length limits is disabled and does not meet the requirement.`n`n"
        $Message += "NOTE: This setting is only available within the built-in OS security template of Windows 10 Release 2004 and Server 2022 (or newer)."
        Write-Warning $Message
        $result = $false
        [bool]$setting = $PasswordPolicy.RelaxMinimumPasswordLengthLimits
    } else {
        $Message = "1.1.6 The Relax minimum password length limits is missing or set incorrectly and does not meet the requirement.`n`n"
        $Message += "NOTE: This setting is only available within the built-in OS security template of Windows 10 Release 2004 and Server 2022 (or newer)."
        Write-Warning $Message
        $result = $false
        $setting = $PasswordPolicy.RelaxMinimumPasswordLengthLimits
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.6'
        'ConfigurationProfile' = @("Level 1 - Member Server")
        'RecommendationName'= 'Ensure "Relax minimum password length limits" is set to "Enabled"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties
    return $Return
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
function Test-ReversibleEncryption {
    [CmdletBinding()]
    param ()

    # Check the product type
    $ProductType = Get-ProductType
    $Return = @()

    if ($ProductType -eq "2") {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Check if reversible encyrption is disabled on this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "ClearTextPassword") {
                [string]$Setting = $Entry.SettingBoolean
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -eq "false") {
        $Message = "1.1.7 The GPO policy has reversible encryption disabled and does meet the requirement."
        Write-Verbose $Message
        $result = $true
        $Setting = $false
    } else {
        $Message = "1.1.7 The GPO policy has reversible encryption enabled and does not meet the requirement."
        Write-Warning $Message
        $result = $false
        $Setting = $true
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.7'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= 'Ensure "Store passwords using reversible encryption" is set to "Disabled"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if (-not($FGPasswordPolicy.ReversibleEncryptionEnabled)) {
                $Message = "1.1.7 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has reversible encryption disabled and does meet the requirement."
                Write-Verbose $Message
                $Result = $true
            } else {
                $Message = "1.1.7 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has reversible encryption enabled and does not meet the requirement."
                Write-Warning $Message
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.1.7'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= 'Ensure "Store passwords using reversible encryption" is set to "Disabled"'
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.ReversibleEncryptionEnabled
            }
            $Properties.PSTypeNames.Add('psCISBenchmark')
            $Return += $Properties
        }
    }
    return $Return
}

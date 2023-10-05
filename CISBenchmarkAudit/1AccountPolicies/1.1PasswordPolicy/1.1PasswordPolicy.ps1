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

    # Check the product type
    $ProductType = Get-ProductType
    $Return = @()

    if ($ProductType -eq 2) {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    #Find the Password History Size applied to this machine
    foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "PasswordHistorySize") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark

    if ($Setting -ge "24") {
        $result = $true
    } else {
        $result = $false
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.1'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Enforce password history' is set to '24 or more password(s)'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.PasswordHistoryCount -ge "24") {
                $Result = $true
            } else {
                $result = $false
            }

            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.1.1'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= "Ensure 'Enforce password history' is set to '24 or more password(s)'"
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
function Test-PasswordPolicyMaxPasswordAge {
    [CmdletBinding()]
    param ()

    # Check the product type
    $ProductType = Get-ProductType
    $Return = @()

    if ($ProductType -eq "2") {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    #Find the maximum password age applied to this machine
    foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "MaximumPasswordAge") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark

    if ($Setting -gt "0" -and $Setting -le "365") {
        $result = $true
    } else {
        $result = $false
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.2'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.MaxPasswordAge -gt "0" -and $FGPasswordPolicy.MaxPasswordAge -le "365") {
                $Result = $true
            } else {
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.1.2'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= "Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'"
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
function Test-PasswordPolicyMinPasswordAge {
    [CmdletBinding()]
    param ()

    # Check the product type
    $ProductType = Get-ProductType
    $Return = @()

    if ($ProductType -eq "2") {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    # Find the minimum password age applied to this machine
    foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "MinimumPasswordAge") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark

    if ($Setting -gt "0") {
        $result = $true
    } else {
        $result = $false
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.3'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Minimum password age' is set to '1 or more day(s)'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.MinPasswordAge -gt "0") {
                $Result = $true
            } else {
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.1.3'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= "Ensure 'Minimum password age' is set to '1 or more day(s)'"
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
function Test-PasswordPolicyMinPasswordLength {
    [CmdletBinding()]
    param ()
    # Check the product type
    $ProductType = Get-ProductType
    $Return = @()

    if ($ProductType -eq "2") {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    # Find the minimum password length applied to this machine
    foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "MinimumPasswordLength") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark

    if ($Setting -ge "14") {
        $result = $true
    } else {
        $result = $false
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.4'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Minimum password length' is set to '14 or more character(s)'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.MinPasswordLength -ge "14") {
                $Result = $true
            } else {
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.1.4'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= "Ensure 'Minimum password length' is set to '14 or more character(s)'"
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
function Test-PasswordPolicyComplexityEnabled {
    [CmdletBinding()]
    param ()

    # Check the product type
    $ProductType = Get-ProductType
    $Return = @()

    if ($ProductType -eq "2") {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    # Check if password complexity is enabled on this machine
    foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "PasswordComplexity") {
                [bool]$Setting = $Entry.SettingBoolean
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark

    if ($Setting) {
        $result = $true
    } else {
        $result = $false
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.5'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Password must meet complexity requirements' is set to 'Enabled'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.ComplexityEnabled) {
                $Result = $true
            } else {
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.1.5'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= "Ensure 'Password must meet complexity requirements' is set to 'Enabled'"
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
function Test-PasswordPolicyRelaxMinimumPasswordLengthLimits {
    [CmdletBinding()]
    param ()

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    $EntryName = "MACHINE\System\CurrentControlSet\Control\SAM\RelaxMinimumPasswordLengthLimits"
    foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.SecurityOptions) {
            If ($Entry.KeyName -eq $EntryName) {
                [bool]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    if ($Setting -eq $true) {
        $result = $true
    } else {
        $result = $false
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.6'
        'ConfigurationProfile' = @("Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Relax minimum password length limits' is set to 'Enabled'"
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
function Test-PasswordPolicyReversibleEncryption {
    [CmdletBinding()]
    param ()

    # Check the product type
    $ProductType = Get-ProductType
    $Return = @()

    if ($ProductType -eq "2") {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    # Check if reversible encyrption is disabled on this machine
    foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "ClearTextPassword") {
                [string]$Setting = $Entry.SettingBoolean
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark

    if ($Setting -eq "false") {
        $result = $true
        $Setting = $false
    } else {
        $result = $false
        $Setting = $true
    }
    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.1.7'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Store passwords using reversible encryption' is set to 'Disabled'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if (-not($FGPasswordPolicy.ReversibleEncryptionEnabled)) {
                $Result = $true
            } else {
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.1.7'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= "Ensure 'Store passwords using reversible encryption' is set to 'Disabled'"
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

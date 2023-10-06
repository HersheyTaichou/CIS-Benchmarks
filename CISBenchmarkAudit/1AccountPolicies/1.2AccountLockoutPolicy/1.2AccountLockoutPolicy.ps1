<#
.SYNOPSIS
1.2.1 (L1) Ensure 'Account lockout duration' is set to '15 or more minute(s)'

.DESCRIPTION
The command checks the applied domain policy and any fine grained
password policies, to ensure they all meet the lockout duration requirement.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-AccountLockoutPolicyLockoutDuration {
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

    #Find the lockout duration applied to this machine
    foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "LockoutDuration") {
                [int]$Setting = $Entry.SettingNumber
                $RawEntry = $Entry
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    if ($Setting -ge "15") {
        $result = $true
    } else {
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.2.1'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
        'Entry' = $RawEntry
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.LockoutDuration -ge (New-TimeSpan -Minutes 15)) {
                $result = $true
            } else {
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.2.1'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.LockoutDuration
            }
            $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties
        }
    }
    # Return True if everything meets the CIS benchmark, otherwise False
    Return $Return
}

<#
.SYNOPSIS
1.2.2 (L1) Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'

.DESCRIPTION
The command checks the applied domain policy and any fine grained
password policies, to ensure they all meet the lockout threshold requirement.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-AccountLockoutPolicyLockoutThreshold {
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
            If ($Entry.Name -eq "LockoutBadCount") {
                [int]$Setting = $Entry.SettingNumber
                $RawEntry = $Entry
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    if ($Setting -gt "0" -and $Setting -le "5") {
        $result = $true
    } else {
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.2.2'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
        'Entry' = $RawEntry
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.LockoutThreshold -gt "0" -and $FGPasswordPolicy.LockoutThreshold -le "5") {
                $result = $true
            } else {
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.2.2'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= "Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'"
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.LockoutThreshold
            }
            $Properties.PSTypeNames.Add('psCISBenchmark')
            $Return += $Properties
        }
    }
    Return $Return
}

<#
.SYNOPSIS
1.2.3 (L1) Ensure 'Allow Administrator account lockout' is set to 'Enabled'

.DESCRIPTION
The command checks the applied domain policy to ensure that the admin account
lockout is enabled.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-AccountLockoutPolicyAdminLockout {
    [CmdletBinding()]
    param ()

    $Return = @()

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    #Find the maximum password age applied to this machine
    foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "AllowAdministratorLockout") {
                [string]$Setting = $Entry.SettingBoolean
                $RawEntry = $Entry
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    if ($Setting -eq "true") {
        $result = $true
        $Setting = $true
    } elseif ($Setting -eq "false") {
        $result = $false
        $Setting = $false
    } else {
        $result = $false
        $Setting = ""
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.2.3'
        'ConfigurationProfile' = @("Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Allow Administrator account lockout' is set to 'Enabled'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
        'Entry' = $RawEntry
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    return $Return
}

<#
.SYNOPSIS
1.2.4 (L1) Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'

.DESCRIPTION
The command checks the applied domain password policy and any fine grained
password policies, to ensure they all meet the reset lockout count requirement.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-AccountLockoutPolicyResetLockoutCount {
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
            If ($Entry.Name -eq "ResetLockoutCount") {
                [int]$Setting = $Entry.SettingNumber
                $RawEntry = $Entry
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    if ($Setting -ge "15") {
        $result = $true
    } else {
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.2.4'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
        'Entry' = $RawEntry
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.LockoutObservationWindow -ge (New-TimeSpan -Minutes 15)) {
                $result = $true
            } else {
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
            $Properties = [PSCustomObject]@{
                'RecommendationNumber'= '1.2.4'
                'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
                'RecommendationName'= "Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'"
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.LockoutDuration
            }
            $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties
        }
    }
    Return $Return
}
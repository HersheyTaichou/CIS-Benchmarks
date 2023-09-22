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
function Test-LockoutDuration {
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

    #Find the lockout duration applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "LockoutDuration") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -ge "15") {
        $Message = "1.2.1 The GPO account lockout duration is set to " + $Setting + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "1.2.1 The GPO account lockout duration is set to " + $Setting + " and does not meet the requirement. Increase the policy to 24 or greater."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.2.1'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
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
            if ($FGPasswordPolicy.LockoutDuration -ge (New-TimeSpan -Minutes 15)) {
                $Message = "1.2.1 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy lockout duration is set to "+ $FGPasswordPolicy.LockoutDuration + " and does meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
                $result = $true
            } else {
                $Message = "1.2.1 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy lockout duration is set to " + $FGPasswordPolicy.LockoutDuration + " and does not meet the requirement. Set the policy to 24 or greater."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
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
function Test-LockoutThreshold {
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
            If ($Entry.Name -eq "LockoutBadCount") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -gt "0" -and $Setting -le "5") {
        $Message = "1.2.2 The GPO lockout threshold is set to " + $Setting + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "1.2.2 The GPO lockout threshold is set to " + $Setting + " and does not meet the requirement. Make sure the lockout threshold is greater than 0 and less than or equal to 5."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.2.2'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'"
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
            if ($FGPasswordPolicy.LockoutThreshold -gt "0" -and $FGPasswordPolicy.LockoutThreshold -le "5") {
                $Message = "1.2.2 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the lockout threshold set to " + $FGPasswordPolicy.MaxPasswordAge + " and does meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
            } else {
                $Message = "1.2.2 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the lockout threshold set to "+ $FGPasswordPolicy.MaxPasswordAge + " and does not meet the requirement. Make sure the lockout threshold is greater than 0 and less than or equal to 5."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
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
function Test-AdminLockout {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    #Find the maximum password age applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "AllowAdministratorLockout") {
                [string]$Setting = $Entry.SettingBoolean
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -eq "true") {
        $Message = "1.2.3 The GPO Admin lockout is enabled and does meet the requirement."
        Write-Verbose $Message
        $result = $true
        $Setting = $true
    } elseif ($Setting -eq "false") {
        $Message = "1.2.3 The GPO admin lockout is disabled and does not meet the requirement. Make sure admin lockout setting is enabled."
        Write-Warning $Message
        $result = $false
        $Setting = $false
    } else {
        $Message = "1.2.3 The GPO admin lockout is missing and does not meet the requirement. Make sure admin lockout setting is enabled."
        Write-Warning $Message
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
function Test-ResetLockoutCount {
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
            If ($Entry.Name -eq "ResetLockoutCount") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -ge "15") {
        $Message = "1.2.4 The GPO account lockout counter is set to " + $Setting + " minutes and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "1.2.4 The GPO account lockout counter is set to " + $Setting + " minutes and does not meet the requirement. Make sure the minimum time is greater than or equal to 15."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.2.4'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'"
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
            if ($FGPasswordPolicy.LockoutObservationWindow -ge (New-TimeSpan -Minutes 15)) {
                $Message = "1.2.4 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum lockout counter set to " + $FGPasswordPolicy.LockoutObservationWindow + " minutes and does meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
                $result = $true
            } else {
                $Message = "1.2.4 The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum lockout counter set to "+ $FGPasswordPolicy.LockoutObservationWindow + " minutes and does not meet the requirement. Make sure the minimum time is greater than or equal to 15."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
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
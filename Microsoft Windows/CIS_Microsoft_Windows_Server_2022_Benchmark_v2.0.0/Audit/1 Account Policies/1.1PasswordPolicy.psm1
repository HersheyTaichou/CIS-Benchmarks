# This module is designed to provide functions that test for complaince with CIS Benchmarks Version 2.0.0 for Windows Server 2022

. $PSScriptRoot\..\support.ps1

<#
.SYNOPSIS
1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more password(s)' (Automated)

.DESCRIPTION
The command checks the default domain password policy and any fine grained
password policies, to ensure they all meet the 24 password history requirement.
The command will return True if all policies meet the requirement, and false
otherwise.

.PARAMETER FineGrainedPasswordPolicy
Set this to false to skip checking any fine grained password policies. Defaults to True

.EXAMPLE
Test-PasswordHistory
TRUE

.EXAMPLE
Test-PasswordHistory
WARNING: The "12 Passwords Remembered"  Fine Grained Password Policy has the Password history set to 12 and does meet the requirement.
FALSE

#>
function Test-PasswordHistory {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )
    # Check for and install any needed modules
    $Prerequisites = Install-Prerequisites

    if ($Prerequisites.ProductType = "2" -and (-not($FineGrainedPasswordPolicy))) {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    #Find the Password History Size applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "PasswordHistorySize") {
                $PasswordHistoryCount = $Entry.SettingNumber
            }
        }
    }

    # Check if the Password History Size meets the CIS Benchmark
    Write-Verbose "This setting is required for Level 1 compliance."
    if ($PasswordHistoryCount -ge "24") {
        $Message = "The default domain password history is set to " + $PasswordHistoryCount + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The default domain password history is set to " + $PasswordHistoryCount + " and does not meet the requirement. Increase the policy to 24 or greater."
        Write-Warning $Message
        $result = $false
    }

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.PasswordHistoryCount -ge "24") {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the Password history set to "+ $FGPasswordPolicy.PasswordHistoryCount + " and does meet the requirement."
                Write-Verbose $Message
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the Password history set to " + $FGPasswordPolicy.PasswordHistoryCount + " and does not meet the requirement. Increase the policy to 24 or greater."
                Write-Warning $Message
                $result = $false
            }
            $Message = "This policy is applied to `n" + $FGPasswordPolicy.AppliesTo
            Write-Verbose $Message
        }
    }
    # Return True if everything meets the CIS benchmark, otherwise False
    Return $result
}

function Test-MaxPasswordAge {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy = $true
    )
    Write-Verbose "This settings is required for Level 1 compliance."
    $PasswordPolicy = Get-ADDefaultDomainPasswordPolicy
    if ($PasswordPolicy.MaxPasswordAge -gt "0" -and $PasswordPolicy.MaxPasswordAge -le "365") {
        $Message = "The default domain max password age is set to " + $PasswordPolicy.MaxPasswordAge + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The default domain max password age is set to " + $PasswordPolicy.MaxPasswordAge + " and does not meet the requirement. Make sure the max password age is greater than 0 and less than or equal to 365."
        Write-Warning $Message
        $result = $false
    }

    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.MaxPasswordAge -gt "0" -and $FGPasswordPolicy.MaxPasswordAge -le "365") {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the max password age set to " + $FGPasswordPolicy.MaxPasswordAge + " and does meet the requirement."
                Write-Verbose $Message
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the max password age set to "+ $FGPasswordPolicy.MaxPasswordAge + " and does not meet the requirement. Make sure the max password age is greater than 0 and less than or equal to 365."
                Write-Warning $Message
                $result = $false
            }
            $Message = "This policy is applied to `n" + $FGPasswordPolicy.AppliesTo
            Write-Verbose $Message
        }
    }
    Return $result
}

function Test-MinPasswordAge {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy = $true
    )
    Write-Verbose "This settings is required for Level 1 compliance."
    $PasswordPolicy = Get-ADDefaultDomainPasswordPolicy
    if ($PasswordPolicy.MinPasswordAge -gt "0") {
        $Message = "The default domain minimum password age is set to " + $PasswordPolicy.MaxPasswordAge + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The default domain minimum password age is set to " + $PasswordPolicy.MaxPasswordAge + " and does not meet the requirement. Make sure the minimum password age is greater than 0."
        Write-Warning $Message
        $result = $false
    }

    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.MinPasswordAge -gt "0") {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password age set to " + $FGPasswordPolicy.MaxPasswordAge + " and does meet the requirement."
                Write-Verbose $Message
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password age set to "+ $FGPasswordPolicy.MaxPasswordAge + " and does not meet the requirement. Make sure the minimum password age is greater than 0."
                Write-Warning $Message
                $result = $false
            }
            $Message = "This policy is applied to `n" + $FGPasswordPolicy.AppliesTo
            Write-Verbose $Message
        }
    }
    Return $result
}

function Test-MinPasswordLength {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy = $true
    )
    Write-Verbose "This settings is required for Level 1 compliance."
    $PasswordPolicy = Get-ADDefaultDomainPasswordPolicy
    if ($PasswordPolicy.MinPasswordLength -ge "14") {
        $Message = "The default domain minimum password length is set to " + $PasswordPolicy.MinPasswordLength + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The default domain minimum password length is set to " + $PasswordPolicy.MinPasswordLength + " and does not meet the requirement. Make sure the minimum password length is greater or equal to 14."
        Write-Warning $Message
        $result = $false
    }

    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.MinPasswordLength -ge "14") {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password length set to " + $FGPasswordPolicy.MinPasswordLength + " and does meet the requirement."
                Write-Verbose $Message
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password length set to "+ $FGPasswordPolicy.MinPasswordLength + " and does not meet the requirement. Make sure the minimum password length is greater or equal to 14."
                Write-Warning $Message
                $result = $false
            }
            $Message = "This policy is applied to `n" + $FGPasswordPolicy.AppliesTo
            Write-Verbose $Message
        }
    }
    Return $result
}

function Test-ComplexityEnabled {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy = $true
    )
    Write-Verbose "This settings is required for Level 1 compliance."
    $PasswordPolicy = Get-ADDefaultDomainPasswordPolicy
    if ($PasswordPolicy.ComplexityEnabled) {
        $Message = "The default domain policy has complexity enabled and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The default domain policy has complexity disabled and does not meet the requirement."
        Write-Warning $Message
        $result = $false
    }

    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.ComplexityEnabled) {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has complexity enabled and does meet the requirement."
                Write-Verbose $Message
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has complexity disabled and does not meet the requirement."
                Write-Warning $Message
                $result = $false
            }
            $Message = "This policy is applied to `n" + $FGPasswordPolicy.AppliesTo
            Write-Verbose $Message
        }
    }
    Return $result
}

function Test-RelaxMinimumPasswordLengthLimits {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy = $true
    )
    Write-Verbose "This setting is required for Level 1 compliance on Windows Server 2022 or greater."
    $PasswordPolicy = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\SAM" -name "RelaxMinimumPasswordLengthLimits"
    if ($PasswordPolicy.RelaxMinimumPasswordLengthLimits -eq "1") {
        $Message = "The Relax minimum password length limits is enabled and meets the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The Relax minimum password length limits is disabled or missing and may not the requirement"
        Write-Warning $Message
        $result = $false
    }
    Return $result
}

function Test-AccountPolicies {
    [CmdletBinding()]
    param (
        [Parameter()][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][ValidateSet("1","2")][string]$Level = "1",
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][bool]$PasswordHistory = $true,
        [Parameter()][bool]$MaxPasswordAge = $true,
        [Parameter()][bool]$MinPasswordAge = $true,
        [Parameter()][bool]$MinPasswordLength = $true,
        [Parameter()][bool]$ComplexityEnabled = $true,
        [Parameter()][bool]$RelaxMinimumPasswordLengthLimits = $true
    )
    $Result = @()
    if ($ServerType = "DomainController") {
        $PasswordPolicy = (Get-ADDefaultDomainPasswordPolicy)
    } elseif ($ServerType = "MemberServer") {
        secedit /export /cfg secedit.inf
        $secedit = (Get-IniContent .\secedit.inf).Values
        if ($secedit.PasswordComplexity -like "*1*") {$PasswordComplexity = $true} else {$PasswordComplexity = $false}
        $PasswordPolicy = @{
            ComplexityEnabled = $PasswordComplexity;
            PasswordHistoryCount = $secedit.PasswordHistorySize;
            MaxPasswordAge = $secedit.MaximumPasswordAge;
            MinPasswordAge = $secedit.MinimumPasswordAge;
            MinPasswordLength = $secedit.MinimumPasswordLength;
        }
        Remove-Item .\secedit.inf
    }
    if ($PasswordHistory -and $Level -eq "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Password History requirement"
        $Output = Test-PasswordHistory -PasswordPolicy $PasswordPolicy
        $Properties = [ordered]@{
            'Recommendation Number'= '1.1.1'
            'Configuration Profile' = "Level 1"
            'Recommendation Name'= 'Ensure "Enforce password history" is set to "24 or more password(s)"'
            'Result'= $Output
        }
        $Result += New-Object -TypeName PSObject -Property $Properties
    }
    if ($MaxPasswordAge -and $Level -eq "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Max Password Age requirement"
        $Output = Test-MaxPasswordAge
        $Properties = [ordered]@{
            'Recommendation Number'= '1.1.2'
            'Configuration Profile' = "Level 1"
            'Recommendation Name'= 'Ensure "Maximum password age" is set to "365 or fewer days, but not 0"'
            'Result'= $Output
        }
        $Result += New-Object -TypeName PSObject -Property $Properties
    }
    if ($MinPasswordAge -and $Level -eq "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Minimum Password Age requirement"
        $Output = Test-MinPasswordAge
        $Properties = [ordered]@{
            'Recommendation Number'= '1.1.3'
            'Configuration Profile' = "Level 1"
            'Recommendation Name'= 'Ensure "Minimum password age" is set to "1 or more day(s)"'
            'Result'= $Output
        }
        $Result += New-Object -TypeName PSObject -Property $Properties
    }
    if ($MinPasswordLength -and $Level -eq "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Minimum Password Length requirement"
        $Output = Test-MinPasswordLength
        $Properties = [ordered]@{
            'Recommendation Number'= '1.1.4'
            'Configuration Profile' = "Level 1"
            'Recommendation Name'= 'Ensure "Minimum password length" is set to "14 or more character(s)"'
            'Result'= $Output
        }
        $Result += New-Object -TypeName PSObject -Property $Properties
    }
    if ($ComplexityEnabled -and $Level -eq "1") {
        Write-Verbose ""
        Write-Verbose "Testing to make sure Password Complexity is Enabled"
        $Output = Test-ComplexityEnabled
        $Properties = [ordered]@{
            'Recommendation Number'= '1.1.5'
            'Configuration Profile' = "Level 1"
            'Recommendation Name'= 'Ensure "Password must meet complexity requirements" is set to "Enabled"'
            'Result'= $Output
        }
        $Result += New-Object -TypeName PSObject -Property $Properties
    }
    if ($RelaxMinimumPasswordLengthLimits -and $Level -eq "1" -and $ServerType -eq "MemberServer") {
        Write-Verbose ""
        Write-Verbose "Testing to make sure Password Complexity is Enabled"
        $Output = Test-RelaxMinimumPasswordLengthLimits
        $Properties = [ordered]@{
            'Recommendation Number'= '1.1.6'
            'Configuration Profile' = "Level 1"
            'Recommendation Name'= 'Ensure "Relax minimum password length limits" is set to "Enabled"'
            'Result'= $Output
        }
        $Result += New-Object -TypeName PSObject -Property $Properties
    } else {
        $Properties = [ordered]@{
            'Recommendation Number'= '1.1.6'
            'Configuration Profile' = "Level 1 - Member Server"
            'Recommendation Name'= 'Ensure "Relax minimum password length limits" is set to "Enabled"'
            'Result'= $null
        }
        $Result += New-Object -TypeName PSObject -Property $Properties
    }
    return $Result
}

Export-ModuleMember -Function Test-AccountPolicies, Test-PasswordHistory, Test-MaxPasswordAge, Test-MinPasswordAge, Test-MinPasswordLength, Test-ComplexityEnabled
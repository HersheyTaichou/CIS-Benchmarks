# This module is designed to provide functions that test for complaince with CIS Benchmarks Version 2.0.0 for Windows Server 2022
# 

<#
.SYNOPSIS
1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more password(s)' (Automated)

.DESCRIPTION
The command checks the default domain password policy and any fine grained password policies, to ensure they all meet the 24 password history requirement. The command will return True if all policies meet the requirement, and false otherwise.

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
        [Parameter()][bool]$FineGrainedPasswordPolicy = $true
    )
    Write-Verbose "This settings is required for Level 1 compliance."
    $PasswordPolicy = Get-ADDefaultDomainPasswordPolicy
    if ($PasswordPolicy.PasswordHistoryCount -lt "24") {
        $Message = "The default domain password history is set to " + $PasswordPolicy.PasswordHistoryCount + " and does not meet the requirement. Increase the policy to 24 or greater."
        Write-Warning $Message
        $result = $false
    } else {
        $Message = "The default domain password history is set to " + $PasswordPolicy.PasswordHistoryCount + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    }

    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.PasswordHistoryCount -lt "24") {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the Password history set to " + $FGPasswordPolicy.PasswordHistoryCount + " and does not meet the requirement. Increase the policy to 24 or greater."
                Write-Warning $Message
                $result = $false
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the Password history set to "+ $FGPasswordPolicy.PasswordHistoryCount + " and does meet the requirement."
                Write-Verbose $Message
            }
            $Message = "This policy is applied to `n" + $FGPasswordPolicy.AppliesTo
            Write-Verbose $Message
        }
    }
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

function Test-AccountPolicies {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$PasswordHistory = $true,
        [Parameter()][bool]$MaxPasswordAge = $true,
        [Parameter()][bool]$MinPasswordAge = $true
    )
    $Result = @()
    if ($PasswordHistory) {
        Write-Verbose ""
        Write-Verbose "Testing the Password History requirement"
        $Output = Test-PasswordHistory
        $Properties = [ordered]@{
            'Recommendation Number'= '1.1.1'
            'Configuration Profile' = "Level 1"
            'Recommendation Name'= 'Ensure "Enforce password history" is set to "24 or more password(s)"'
            'Result'= $Output
        }
        $Result += New-Object -TypeName PSObject -Property $Properties
    }
    if ($MaxPasswordAge) {
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
    if ($MinPasswordAge) {
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
    return $Result
}

Export-ModuleMember -Function Test-AccountPolicies, Test-PasswordHistory, Test-MaxPasswordAge, Test-MinPasswordAge
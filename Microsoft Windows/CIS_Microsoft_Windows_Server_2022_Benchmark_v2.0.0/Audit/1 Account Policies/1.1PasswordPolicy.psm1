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

    if ($Prerequisites.ProductType -eq 2 -and (-not($FineGrainedPasswordPolicy))) {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    #Find the Password History Size applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "PasswordHistorySize") {
                [int]$SettingNumber = $Entry.SettingNumber
            }
        }
    }

    # Check if the Password History Size meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($SettingNumber -ge "24") {
        $Message = "The default domain password history is set to " + $SettingNumber + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The default domain password history is set to " + $SettingNumber + " and does not meet the requirement. Increase the policy to 24 or greater."
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
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the Password history set to " + $FGPasswordPolicy.PasswordHistoryCount + " and does not meet the requirement. Set the policy to 24 or greater."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $false
            }
        }
    }
    # Return True if everything meets the CIS benchmark, otherwise False
    Return $result
}

function Test-MaxPasswordAge {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )
    # Check for and install any needed modules
    $Prerequisites = Install-Prerequisites

    if ($Prerequisites.ProductType -eq "2" -and (-not($FineGrainedPasswordPolicy))) {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    #Find the maximum password age applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "MaximumPasswordAge") {
                [int]$SettingNumber = $Entry.SettingNumber
            }
        }
    }

    # Check if the max password age meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($SettingNumber -gt "0" -and $SettingNumber -le "365") {
        $Message = "The default domain password history is set to " + $SettingNumber + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The default domain password history is set to " + $SettingNumber + " and does not meet the requirement. Make sure the max password age is greater than 0 and less than or equal to 365."
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
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the max password age set to "+ $FGPasswordPolicy.MaxPasswordAge + " and does not meet the requirement. Make sure the max password age is greater than 0 and less than or equal to 365."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $false
            }
        }
    }
    Return $result
}

function Test-MinPasswordAge {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )
    # Check for and install any needed modules
    $Prerequisites = Install-Prerequisites

    if ($Prerequisites.ProductType -eq "2" -and (-not($FineGrainedPasswordPolicy))) {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Find the minimum password age applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "MinimumPasswordAge") {
                [int]$SettingNumber = $Entry.SettingNumber
            }
        }
    }

    # Check if the minimum password age meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($SettingNumber -gt "0") {
        $Message = "The default domain minimum password age is set to " + $SettingNumber + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The default domain minimum password age is set to " + $SettingNumber + " and does not meet the requirement. Make sure the minimum password age is greater than 0."
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
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password age set to "+ $FGPasswordPolicy.MaxPasswordAge + " and does not meet the requirement. Make sure the minimum password age is greater than 0."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $false
            }
        }
    }
    Return $result
}

function Test-MinPasswordLength {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )
    # Check for and install any needed modules
    $Prerequisites = Install-Prerequisites

    if ($Prerequisites.ProductType -eq "2" -and (-not($FineGrainedPasswordPolicy))) {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Find the minimum password length applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "MinimumPasswordLength") {
                [int]$SettingNumber = $Entry.SettingNumber
            }
        }
    }

    # Check if the minimum password length meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($SettingNumber -ge "14") {
        $Message = "The default domain minimum password length is set to " + $SettingNumber + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The default domain minimum password length is set to " + $SettingNumber + " and does not meet the requirement. Make sure the minimum password length is greater than or equal to 14."
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
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password length set to "+ $FGPasswordPolicy.MinPasswordLength + " and does not meet the requirement. Make sure the minimum password length is greater or equal to 14."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $false
            }
        }
    }
    Return $result
}

function Test-ComplexityEnabled {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )

    # Check for and install any needed modules
    $Prerequisites = Install-Prerequisites

    if ($Prerequisites.ProductType -eq "2" -and (-not($FineGrainedPasswordPolicy))) {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Check if password complexity is enabled on this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "PasswordComplexity") {
                [bool]$SettingBoolean = $Entry.SettingBoolean
            }
        }
    }

    # Check if the password complexity setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($SettingBoolean) {
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
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has complexity disabled and does not meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $false
            }
        }
    }
    Return $result
}

function Test-RelaxMinimumPasswordLengthLimits {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )
    # This setting is required for Level 1 compliance on Windows Server 2022 or greater.
    $PasswordPolicy = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\SAM" -name "RelaxMinimumPasswordLengthLimits"
    if ($PasswordPolicy.RelaxMinimumPasswordLengthLimits -eq "1") {
        $Message = "The Relax minimum password length limits is enabled and meets the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The Relax minimum password length limits is disabled or missing and may not meet the requirement."
        Write-Warning $Message
        $result = $false
    }
    Return $result
}

function Test-ReversibleEncryption {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )

    # Check for and install any needed modules
    $Prerequisites = Install-Prerequisites

    if ($Prerequisites.ProductType -eq "2" -and (-not($FineGrainedPasswordPolicy))) {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Check if reversible encyrption is disabled on this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "ClearTextPassword") {
                [bool]$SettingBoolean = $Entry.SettingBoolean
            }
        }
    }

    # Check if the reversible encryption setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if (-not($SettingBoolean)) {
        $Message = "The default domain policy has reversible encryption disabled and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The default domain policy has reversible encryption enabled and does not meet the requirement."
        Write-Warning $Message
        $result = $false
    }

    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if (-not($FGPasswordPolicy.ReversibleEncryptionEnabled)) {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has reversible encryption disabled and does meet the requirement."
                Write-Verbose $Message
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has reversible encryption enabled and does not meet the requirement."
                Write-Warning $Message
                $result = $false
            }
        }
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
        [Parameter()][bool]$RelaxMinimumPasswordLengthLimits = $true,
        [Parameter()][bool]$ReversibleEncryption = $true
    )
    $Result = @()
    if ($PasswordHistory -and $Level -eq "1") {
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
    if ($ReversibleEncryption -and $Level -eq "1") {
        Write-Verbose ""
        Write-Verbose "Testing to make sure Reversible Encryption is Disabled"
        $Output = Test-ReversibleEncryption
        $Properties = [ordered]@{
            'Recommendation Number'= '1.1.7'
            'Configuration Profile' = "Level 1"
            'Recommendation Name'= 'Ensure "Store passwords using reversible encryption" is set to "Disabled"'
            'Result'= $Output
        }
        $Result += New-Object -TypeName PSObject -Property $Properties
    }
    return $Result
}

Export-ModuleMember -Function Test-AccountPolicies, Test-PasswordHistory, Test-MaxPasswordAge, Test-MinPasswordAge, Test-MinPasswordLength, Test-ComplexityEnabled
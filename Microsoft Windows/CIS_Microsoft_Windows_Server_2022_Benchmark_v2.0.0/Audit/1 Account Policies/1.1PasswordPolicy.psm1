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
    $Prerequisites = 
    $Return = @()

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
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -ge "24") {
        $Message = "The GPO password history is set to " + $Setting + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The GPO password history is set to " + $Setting + " and does not meet the requirement. Increase the policy to 24 or greater."
        Write-Warning $Message
        $result = $false
    }
    $Properties = [ordered]@{
        'Recommendation Number'= '1.1.1'
        'Configuration Profile' = "Level 1"
        'Recommendation Name'= 'Ensure "Enforce password history" is set to "24 or more password(s)"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Return += New-Object -TypeName PSObject -Property $Properties

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
                $Result = $true
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the Password history set to " + $FGPasswordPolicy.PasswordHistoryCount + " and does not meet the requirement. Set the policy to 24 or greater."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $fals
                $Source = $FGPasswordPolicy.Name + "Fine Grained Password Policy"
            }
            $Properties = [ordered]@{
                'Recommendation Number'= '1.1.1'
                'Configuration Profile' = "Level 1"
                'Recommendation Name'= 'Ensure "Enforce password history" is set to "24 or more password(s)"'
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.PasswordHistoryCount
            }
            $Return += New-Object -TypeName PSObject -Property $Propertiese
        }
    }
    # Return True if everything meets the CIS benchmark, otherwise False
    return $Return
}

function Test-MaxPasswordAge {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )
    # Check for and install any needed modules
    $Prerequisites = Install-Prerequisites
    $Return = @()

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
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -gt "0" -and $Setting -le "365") {
        $Message = "The GPO password history is set to " + $Setting + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The GPO password history is set to " + $Setting + " and does not meet the requirement. Make sure the max password age is greater than 0 and less than or equal to 365."
        Write-Warning $Message
        $result = $false
    }
    $Properties = [ordered]@{
        'Recommendation Number'= '1.1.2'
        'Configuration Profile' = "Level 1"
        'Recommendation Name'= 'Ensure "Maximum password age" is set to "365 or fewer days, but not 0"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Return += New-Object -TypeName PSObject -Property $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.MaxPasswordAge -gt "0" -and $FGPasswordPolicy.MaxPasswordAge -le "365") {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the max password age set to " + $FGPasswordPolicy.MaxPasswordAge + " and does meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
                $Result = $true
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the max password age set to "+ $FGPasswordPolicy.MaxPasswordAge + " and does not meet the requirement. Make sure the max password age is greater than 0 and less than or equal to 365."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $fals
                $Source = $FGPasswordPolicy.Name + "Fine Grained Password Policy"
            }
            $Properties = [ordered]@{
                'Recommendation Number'= '1.1.2'
                'Configuration Profile' = "Level 1"
                'Recommendation Name'= 'Ensure "Maximum password age" is set to "365 or fewer days, but not 0"'
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.MaxPasswordAge
            }
            $Return += New-Object -TypeName PSObject -Property $Propertiese
        }
    }
    return $Return
}

function Test-MinPasswordAge {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )
    # Check for and install any needed modules
    $Prerequisites = Install-Prerequisites
    $Return = @()

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
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -gt "0") {
        $Message = "The GPO minimum password age is set to " + $Setting + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The GPO minimum password age is set to " + $Setting + " and does not meet the requirement. Make sure the minimum password age is greater than 0."
        Write-Warning $Message
        $result = $false
    }
    $Properties = [ordered]@{
        'Recommendation Number'= '1.1.3'
        'Configuration Profile' = "Level 1"
        'Recommendation Name'= 'Ensure "Minimum password age" is set to "1 or more day(s)"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Return += New-Object -TypeName PSObject -Property $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.MinPasswordAge -gt "0") {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password age set to " + $FGPasswordPolicy.MaxPasswordAge + " and does meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
                $Result = $true
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password age set to "+ $FGPasswordPolicy.MaxPasswordAge + " and does not meet the requirement. Make sure the minimum password age is greater than 0."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $fals
                $Source = $FGPasswordPolicy.Name + "Fine Grained Password Policy"
            }
            $Properties = [ordered]@{
                'Recommendation Number'= '1.1.3'
                'Configuration Profile' = "Level 1"
                'Recommendation Name'= 'Ensure "Minimum password age" is set to "1 or more day(s)"'
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.MaxPasswordAge
            }
            $Return += New-Object -TypeName PSObject -Property $Propertiese
        }
    }
    return $Return
}

function Test-MinPasswordLength {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )
    # Check for and install any needed modules
    $Prerequisites = Install-Prerequisites
    $Return = @()

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
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -ge "14") {
        $Message = "The GPO minimum password length is set to " + $Setting + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The GPO minimum password length is set to " + $Setting + " and does not meet the requirement. Make sure the minimum password length is greater than or equal to 14."
        Write-Warning $Message
        $result = $false
    }
    $Properties = [ordered]@{
        'Recommendation Number'= '1.1.4'
        'Configuration Profile' = "Level 1"
        'Recommendation Name'= 'Ensure "Minimum password length" is set to "14 or more character(s)"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Return += New-Object -TypeName PSObject -Property $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.MinPasswordLength -ge "14") {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password length set to " + $FGPasswordPolicy.MinPasswordLength + " and does meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
                $Result = $true
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has the minimum password length set to "+ $FGPasswordPolicy.MinPasswordLength + " and does not meet the requirement. Make sure the minimum password length is greater or equal to 14."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $fals
                $Source = $FGPasswordPolicy.Name + "Fine Grained Password Policy"
            }
            $Properties = [ordered]@{
                'Recommendation Number'= '1.1.4'
                'Configuration Profile' = "Level 1"
                'Recommendation Name'= 'Ensure "Minimum password length" is set to "14 or more character(s)"'
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.MinPasswordLength
            }
            $Return += New-Object -TypeName PSObject -Property $Propertiese
        }
    }
    return $Return
}

function Test-ComplexityEnabled {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )

    # Check for and install any needed modules
    $Prerequisites = Install-Prerequisites
    $Return = @()

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
                [bool]$Setting = $Entry.SettingBoolean
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting) {
        $Message = "The GPO policy has complexity enabled and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "The GPO policy has complexity disabled and does not meet the requirement."
        Write-Warning $Message
        $result = $false
    }
    $Properties = [ordered]@{
        'Recommendation Number'= '1.1.5'
        'Configuration Profile' = "Level 1"
        'Recommendation Name'= 'Ensure "Password must meet complexity requirements" is set to "Enabled"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Return += New-Object -TypeName PSObject -Property $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if ($FGPasswordPolicy.ComplexityEnabled) {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has complexity enabled and does meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Verbose $Message
                $Result = $true
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has complexity disabled and does not meet the requirement."
                $Message += "`nThis policy is applied to `n" + $FGPasswordPolicy.AppliesTo
                Write-Warning $Message
                $result = $fals
                $Source = $FGPasswordPolicy.Name + "Fine Grained Password Policy"
            }
            $Properties = [ordered]@{
                'Recommendation Number'= '1.1.5'
                'Configuration Profile' = "Level 1"
                'Recommendation Name'= 'Ensure "Password must meet complexity requirements" is set to "Enabled"'
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.ComplexityEnabled
            }
            $Return += New-Object -TypeName PSObject -Property $Propertiese
        }
    }
    return $Return
}

function Test-RelaxMinimumPasswordLengthLimits {
    [CmdletBinding()]
    param ()
    # This setting is required for Level 1 compliance on Windows Server 2022 or greater.
    $PasswordPolicy = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\SAM" -name "RelaxMinimumPasswordLengthLimits"

    # Check if the GPO setting meets the CIS Benchmark
    if ($PasswordPolicy.RelaxMinimumPasswordLengthLimits -eq "1") {
        $Message = "The Relax minimum password length limits is enabled and meets the requirement."
        Write-Verbose $Message
        $result = $true
        [bool]$Setting = $PasswordPolicy.RelaxMinimumPasswordLengthLimits
    } elseif ($PasswordPolicy.RelaxMinimumPasswordLengthLimits -eq "0") {
        $Message = "The Relax minimum password length limits is disabled and does not meet the requirement.`n`n"
        $Message += "NOTE: This setting is only available within the built-in OS security template of Windows 10 Release 2004 and Server 2022 (or newer)."
        Write-Warning $Message
        $result = $false
        [bool]$setting = $PasswordPolicy.RelaxMinimumPasswordLengthLimits
    } else {
        $Message = "The Relax minimum password length limits is missing or set incorrectly and does not meet the requirement.`n`n"
        $Message += "NOTE: This setting is only available within the built-in OS security template of Windows 10 Release 2004 and Server 2022 (or newer)."
        Write-Warning $Message
        $result = $false
        $setting = $PasswordPolicy.RelaxMinimumPasswordLengthLimits
    }
    $Properties = [ordered]@{
        'Recommendation Number'= '1.1.6'
        'Configuration Profile' = "Level 1"
        'Recommendation Name'= 'Ensure "Relax minimum password length limits" is set to "Enabled"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Return += New-Object -TypeName PSObject -Property $Properties
    return $Return
}

function Test-ReversibleEncryption {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )

    # Check for and install any needed modules
    $Prerequisites = Install-Prerequisites
    $Return = @()

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
                [string]$Setting = $Entry.SettingBoolean
            }
        }
    }

    # Check if the GPO setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -eq "false") {
        $Message = "The GPO policy has reversible encryption disabled and does meet the requirement."
        Write-Verbose $Message
        $result = $true
        $Setting = $false
    } else {
        $Message = "The GPO policy has reversible encryption enabled and does not meet the requirement."
        Write-Warning $Message
        $result = $false
        $Setting = $true
    }
    $Properties = [ordered]@{
        'Recommendation Number'= '1.1.7'
        'Configuration Profile' = "Level 1"
        'Recommendation Name'= 'Ensure "Store passwords using reversible encryption" is set to "Disabled"'
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Return += New-Object -TypeName PSObject -Property $Properties

    # If enabled, check if the Fine Grained Password Policies meet the CIS Benchmark
    if ($FineGrainedPasswordPolicy) {
        $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
        $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
        Write-Verbose $Message
        foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
            if (-not($FGPasswordPolicy.ReversibleEncryptionEnabled)) {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has reversible encryption disabled and does meet the requirement."
                Write-Verbose $Message
                $Result = $true
            } else {
                $Message = "The `"" + $FGPasswordPolicy.Name + "`" Fine Grained Password Policy has reversible encryption enabled and does not meet the requirement."
                Write-Warning $Message
                $result = $false
            }
            $Source = $FGPasswordPolicy.Name + "Fine Grained Password Policy"
            $Properties = [ordered]@{
                'Recommendation Number'= '1.1.7'
                'Configuration Profile' = "Level 1"
                'Recommendation Name'= 'Ensure "Store passwords using reversible encryption" is set to "Disabled"'
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.ReversibleEncryptionEnabled
            }
            $Return += New-Object -TypeName PSObject -Property $Properties
        }
    }
    return $Return
}

function Test-PasswordPolicy {
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
    if ($PasswordHistory -and $Level -ge "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Password History requirement"
        $Result += Test-PasswordHistory
    }
    if ($MaxPasswordAge -and $Level -ge "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Max Password Age requirement"
        $Result += Test-MaxPasswordAge
    }
    if ($MinPasswordAge -and $Level -ge "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Minimum Password Age requirement"
        $Result += Test-MinPasswordAge
    }
    if ($MinPasswordLength -and $Level -ge "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Minimum Password Length requirement"
        $Result += Test-MinPasswordLength
    }
    if ($ComplexityEnabled -and $Level -ge "1") {
        Write-Verbose ""
        Write-Verbose "Testing to make sure Password Complexity is Enabled"
        $Result += Test-ComplexityEnabled
    }
    if ($RelaxMinimumPasswordLengthLimits -and $Level -ge "1" -and $ServerType -eq "MemberServer") {
        Write-Verbose ""
        Write-Verbose "Testing to make sure Password Complexity is Enabled"
        $Result += Test-RelaxMinimumPasswordLengthLimits
    }
    if ($ReversibleEncryption -and $Level -ge "1") {
        Write-Verbose ""
        Write-Verbose "Testing to make sure Reversible Encryption is Disabled"
        $Result += Test-ReversibleEncryption
    }
    return $Result
}

Export-ModuleMember -Function Test-PasswordPolicy, Test-PasswordHistory, Test-MaxPasswordAge, Test-MinPasswordAge, Test-MinPasswordLength, Test-ComplexityEnabled
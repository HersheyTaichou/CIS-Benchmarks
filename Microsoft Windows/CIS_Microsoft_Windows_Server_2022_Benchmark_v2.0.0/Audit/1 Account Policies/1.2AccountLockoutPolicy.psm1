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
function Test-LockoutDuration {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )
    # Check for and install any needed modules
    $Prerequisites = Install-Prerequisites

    $Return = @()

    if ($Prerequisites.ProductType -eq 2 -and (-not($FineGrainedPasswordPolicy))) {
        Write-Verbose "This is a domain controller, checking the Fine Grained Password Policies"
        $FineGrainedPasswordPolicy = $true
    }

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    #Find the lockout duration applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "LockoutDuration") {
                [int]$SettingNumber = $Entry.SettingNumber
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($SettingNumber -ge "15") {
        $Message = "1.2.1 The GPO account lockout duration is set to " + $SettingNumber + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "1.2.1 The GPO account lockout duration is set to " + $SettingNumber + " and does not meet the requirement. Increase the policy to 24 or greater."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [ordered]@{
        'Recommendation Number'= '1.2.1'
        'Configuration Profile' = "Level 1"
        'Recommendation Name'= "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $SettingNumber
    }
    $Return += New-Object -TypeName PSObject -Property $Properties

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
            $Source = $FGPasswordPolicy.Name + "Fine Grained Password Policy"
            $Properties = [ordered]@{
                'Recommendation Number'= '1.2.1'
                'Configuration Profile' = "Level 1"
                'Recommendation Name'= "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.LockoutDuration
            }
            $Return += New-Object -TypeName PSObject -Property $Properties
        }
    }
    # Return True if everything meets the CIS benchmark, otherwise False
    Return $Return
}

function Test-LockoutThreshold {
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
            If ($Entry.Name -eq "LockoutBadCount") {
                [int]$SettingNumber = $Entry.SettingNumber
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($SettingNumber -gt "0" -and $SettingNumber -le "5") {
        $Message = "1.2.2 The GPO lockout threshold is set to " + $SettingNumber + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "1.2.2 The GPO lockout threshold is set to " + $SettingNumber + " and does not meet the requirement. Make sure the lockout threshold is greater than 0 and less than or equal to 5."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [ordered]@{
        'Recommendation Number'= '1.2.2'
        'Configuration Profile' = "Level 1"
        'Recommendation Name'= "Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $SettingNumber
    }
    $Return += New-Object -TypeName PSObject -Property $Properties

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
            $Source = $FGPasswordPolicy.Name + "Fine Grained Password Policy"
            $Properties = [ordered]@{
                'Recommendation Number'= '1.2.2'
                'Configuration Profile' = "Level 1"
                'Recommendation Name'= "Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'"
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.LockoutThreshold
            }
            $Return += New-Object -TypeName PSObject -Property $Properties
        }
    }
    Return $Return
}

function Test-AdminLockout {
    [CmdletBinding()]
    param ()
    $Return = @()
    $Message =  "This script is currently unable to check the 'Allow Administrator account lockout' setting. You will need to check the settings manually.`n`n"
    $Message += "To check the group policies, go to this location:`n"
    $Message += "Computer Configuration\Policies\Windows Settings\Security Settings\Account Policies\Account Lockout Policies\Allow Administrator account lockout`n`n"
    $Message += "To check in the Local Security Policy, go to:`n"
    $Message += "Security Settings\Account Policies\Account Lockout Policies\Allow Administrator account lockout`n`n"
    $Message += "NOTE: This setting applies only to OSes patched as of October 11, 2022 (see MS KB5020282)."
    Write-Host $Message

    $result = ""
    $SettingNumber = ""

    $Properties = [ordered]@{
        'Recommendation Number'= '1.2.3'
        'Configuration Profile' = "Level 1"
        'Recommendation Name'= "Ensure 'Allow Administrator account lockout' is set to 'Enabled'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $SettingNumber
    }
    $Return += New-Object -TypeName PSObject -Property $Properties

    return $Return
}

function Test-ResetLockoutCount {
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
            If ($Entry.Name -eq "ResetLockoutCount") {
                [int]$SettingNumber = $Entry.SettingNumber
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($SettingNumber -ge "15") {
        $Message = "1.2.4 The GPO account lockout counter is set to " + $SettingNumber + " minutes and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "1.2.4 The GPO account lockout counter is set to " + $SettingNumber + " minutes and does not meet the requirement. Make sure the minimum time is greater than or equal to 15."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [ordered]@{
        'Recommendation Number'= '1.2.4'
        'Configuration Profile' = "Level 1"
        'Recommendation Name'= "Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $SettingNumber
    }
    $Return += New-Object -TypeName PSObject -Property $Properties

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
            $Source = $FGPasswordPolicy.Name + "Fine Grained Password Policy"
            $Properties = [ordered]@{
                'Recommendation Number'= '1.2.4'
                'Configuration Profile' = "Level 1"
                'Recommendation Name'= "Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'"
                'Source' = $Source
                'Result'= $result
                'Setting' = $FGPasswordPolicy.LockoutDuration
            }
            $Return += New-Object -TypeName PSObject -Property $Properties
        }
    }
    Return $Return
}

function Test-AccountLockoutPolicy {
    [CmdletBinding()]
    param (
        [Parameter()][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][ValidateSet("1","2")][string]$Level = "1",
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][bool]$LockoutDuration = $true,
        [Parameter()][bool]$LockoutThreshold = $true,
        [Parameter()][bool]$AdminLockout = $true,
        [Parameter()][bool]$ResetLockoutCount = $true
    )
    $Result = @()
    if ($LockoutDuration -and $Level -ge "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Lockout Duration requirement"
        $Result += Test-LockoutDuration
    }
    if ($LockoutThreshold -and $Level -ge "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Lockout Threshold requirement"
        $Result += Test-LockoutThreshold
    }
    if ($AdminLockout -and $Level -ge "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Admin Lockout requirement"
        $Result += Test-AdminLockout
    }
    if ($ResetLockoutCount -and $Level -ge "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Reset Lockout Counter requirement"
        $Result += Test-ResetLockoutCount
    }
    return $Result
}

Export-ModuleMember -Function Test-AccountLockoutPolicy, Test-LockoutDuration, Test-LockoutThreshold, Test-AdminLockout, Test-ResetLockoutCount
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
    $null = Install-Prerequisites

    $Return = @()

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
        'ConfigurationProfile' = "Level 1"
        'RecommendationName'= "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

function Test-UserRightsAssignment {
    [CmdletBinding()]
    param (
        [Parameter()][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][ValidateSet("1","2")][string]$Level = "1",
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][bool]$LockoutDuration = $true
    )
    $Result = @()
    if ($LockoutDuration -and $Level -ge "1") {
        Write-Verbose ""
        Write-Verbose "Testing the Lockout Duration requirement"
        $Result += Test-LockoutDuration
    }
    return $Result
}

Export-ModuleMember -Function Test-AccountLockoutPolicy, Test-LockoutDuration, Test-LockoutThreshold, Test-AdminLockout, Test-ResetLockoutCount
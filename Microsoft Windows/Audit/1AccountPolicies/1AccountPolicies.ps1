. $PSScriptRoot\1.1PasswordPolicy\1.1PasswordPolicy.ps1
. $PSScriptRoot\1.2AccountLockoutPolicy\1.2AccountLockoutPolicy.ps1

function Test-PasswordPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet("1","2")][string]$Level,
        [Parameter(Mandatory=$true)][ValidateSet("DomainController","MemberServer")][string]$ServerType,
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
    if ($RelaxMinimumPasswordLengthLimits -and $Level -ge "1") {
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
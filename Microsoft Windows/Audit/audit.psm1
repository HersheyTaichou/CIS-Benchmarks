#Requires -RunAsAdministrator

# Load supporting files
$SupportFiles = @(
    "\1 Account Policies\1.1PasswordPolicy.psm1",
    "\1 Account Policies\1.2AccountLockoutPolicy.psm1"
)

foreach ($File in $SupportFiles) {
    $FilePath = $PSScriptRoot + $File
    if (Test-Path $FilePath) {
        $FilePath
    }
}

function Test-CISBenchmark {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet("1","2")][string]$Level,
        [Parameter(Mandatory=$true)][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][bool]$PasswordPolicy = $true,
        [Parameter()][bool]$AccountLockoutPolicy = $true
    )
    $Return = @()
    if ($PasswordPolicy) {
        $Return += Test-PasswordPolicy -ServerType $ServerType -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    }
    if ($AccountLockoutPolicy) {
        $Return += Test-AccountLockoutPolicy  -ServerType $ServerType -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    }
    return $Return
}

$ModuleMemberFunctions += "Test-CISBenchmark"
Export-ModuleMember -Function $ModuleMemberFunctions
Import-Module "$PSScriptRoot\1 Account Policies\1.1PasswordPolicy.psm1"
Import-Module "$PSScriptRoot\1 Account Policies\1.2AccountLockoutPolicy.psm1"

function Test-CISBenchmark  {
    [CmdletBinding()]
    param (
        [Parameter()][ValidateSet("DomainController","MemberServer")][string]$ServerType = "DomainController",
        [Parameter()][ValidateSet("1","2")][string]$Level = "1",
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][bool]$PasswordPolicy = $true,
        [Parameter()][bool]$AccountLockoutPolicy = $true
    )
    $Return = @()
    if ($PasswordPolicy) {
        $Return += Test-PasswordPolicy -ServerType $ServerType -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    }
    if ($AccountLockoutPolicy) {$Return += Test-AccountLockoutPolicy  -ServerType $ServerType -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity}
    return $Return
}
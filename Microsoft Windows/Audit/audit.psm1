#Requires -RunAsAdministrator

function Test-CISBenchmark {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet("1","2")][string]$Level,
        [Parameter(Mandatory=$true)][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][bool]$NextGenerationWindowsSecurity
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
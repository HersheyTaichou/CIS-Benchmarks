# This module is designed to provide functions that test for complaince with CIS Benchmarks Version 2.0.0 for Windows Server 2022
# 1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more password(s)' (Automated)


function Test-PasswordHistory {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )
    Write-Verbose "This settings is required for Level 1 compliance"
    Write-Host "For compliance, password history should be set to 24 or more passwords remembered."
    $PasswordPolicy = Get-ADDefaultDomainPasswordPolicy
    if ($PasswordPolicy.PasswordHistoryCount -lt "24") {
        $message = "Password history is set to " + $PasswordPolicy.PasswordHistoryCount + " and does not meet the requirement. Increase the policy to 24 or greater."
        Write-Warning $message
    } else {
        $message = "Password history is set to " + $PasswordPolicy.PasswordHistoryCount + " and does meet the requirement."
        Write-Host $message -ForegroundColor Green
    }

    #if ($FineGrainedPasswordPolicy) {
    $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
    foreach ($PasswordPolicy in $ADFineGrainedPasswordPolicy) {
        if ($PasswordPolicy.PasswordHistoryCount -lt "24") {
            $message = "Password history is set to " + $PasswordPolicy.PasswordHistoryCount + " and does not meet the requirement. Increase the policy to 24 or greater."
            Write-Warning $message
        } else {
            $message = "Password history is set to " + $PasswordPolicy.PasswordHistoryCount + " and does meet the requirement."
            Write-Host $message -ForegroundColor Green
        }
    }
    #}
}

Export-ModuleMember -Function Test-PasswordHistory
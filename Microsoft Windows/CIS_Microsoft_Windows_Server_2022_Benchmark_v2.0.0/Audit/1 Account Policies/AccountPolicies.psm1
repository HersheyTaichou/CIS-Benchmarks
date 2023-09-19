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
        $Message = "Password history is set to " + $PasswordPolicy.PasswordHistoryCount + " and does not meet the requirement. Increase the policy to 24 or greater."
        Write-Warning $Message
    } else {
        $Message = "Password history is set to " + $PasswordPolicy.PasswordHistoryCount + " and does meet the requirement."
        Write-Host $Message -ForegroundColor Green
    }

    #if ($FineGrainedPasswordPolicy) {
    $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
    $Message = "Checking " + $ADFineGrainedPasswordPolicy.count + " Fine Grained Password Policies."
    Write-Verbose $Message
    foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
        if ($FGPasswordPolicy.PasswordHistoryCount -lt "24") {
            $Message = "The " + $FGPasswordPolicy.Name + " policy has the Password history set to " + $FGPasswordPolicy.PasswordHistoryCount + " and does not meet the requirement. Increase the policy to 24 or greater."
            Write-Warning $Message
        } else {
            $Message = "The " + $FGPasswordPolicy.Name + " policy has the Password history set to "+ $FGPasswordPolicy.PasswordHistoryCount + " and does meet the requirement."
            Write-Host $Message -ForegroundColor Green
        }
    }
    #}
}

Export-ModuleMember -Function Test-PasswordHistory
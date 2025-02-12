<#
.SYNOPSIS
1.2.2 (L1) Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'

.DESCRIPTION
This policy setting determines the number of failed logon attempts before the account is locked.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountLockoutPolicyLockoutThreshold

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.2.2      L1    Ensure 'Account lockout threshold' is set to '5 or fewer inv... Group Policy Settings     True
1.2.2      L1    Ensure 'Account lockout threshold' is set to '5 or fewer inv... Test Policy Fine Grain... True

.NOTES
General notes
#>
function Test-AccountLockoutPolicyLockoutThreshold {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = '1.2.2'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'"
        $Result.Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "LockoutBadCount"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
        $Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Result.Setting -gt "0" -and $Result.Setting -le "5") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }

        $Return += $Result

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType.Number -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $Result = [CISBenchmark]::new()
                $Result.Number = "1.2.2"
                $Result.Level = "L1"
                $Result.Profile = "Domain Controller"
                $Result.Title = "Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                if ($FGPasswordPolicy.LockoutThreshold -gt "0" -and $FGPasswordPolicy.LockoutThreshold -le "5") {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }

                $Result.Setting = [bool]$FGPasswordPolicy.LockoutThreshold
                $Result.Entry = $FGPasswordPolicy
                $Return += $Result
            }
        }
    }

    end {
        return $Return
    }
}

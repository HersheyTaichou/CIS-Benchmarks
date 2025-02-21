<#
.SYNOPSIS
1.2.4 (L1) Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'

.DESCRIPTION
This policy setting determines the length of time before the Account lockout threshold resets to zero.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountLockoutPolicyResetLockoutCount

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.2.4      L1    Ensure 'Reset account lockout counter after' is set to '15 o... Group Policy Settings     True
1.2.4      L1    Ensure 'Reset account lockout counter after' is set to '15 o... Test Policy Fine Grain... True

.NOTES
General notes
#>
function Test-AccountLockoutPolicyResetLockoutCount {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Number = '1.2.4'
        $Level = 'L1'
        
        $Title= "Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'"
		$Result.Source = "Group Policy Settings"

        #Find the Password History Size applied to this machine
        $EntryName = "ResetLockoutCount"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
        $Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Result.Setting -ge "15") {
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
                $Number = '1.2.4'
                $Level = 'L1'
                $Result.Profile = "Domain Controller"
                $Title= "Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                if ($FGPasswordPolicy.LockoutObservationWindow -ge (New-TimeSpan -Minutes 15)) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
                $Result.Setting = [bool]$FGPasswordPolicy.LockoutObservationWindow
                $Result.Entry = $FGPasswordPolicy
                $Return += $Result
            }
        }
    }

    end {
        return $Return
    }
}

<#
.SYNOPSIS
1.2.1 (L1) Ensure 'Account lockout duration' is set to '15 or more minute(s)'

.DESCRIPTION
This policy setting determines the length of time that must pass before a locked account is unlocked and a user can try to log on again.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AccountLockoutPolicyLockoutDuration

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.2.1      L1    Ensure 'Account lockout duration' is set to '15 or more minu... Group Policy Settings     True
1.2.1      L1    Ensure 'Account lockout duration' is set to '15 or more minu... Test Policy Fine Grain... True

.NOTES
General notes
#>
function Test-AccountLockoutPolicyLockoutDuration {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    begin {
        
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Number = '1.2.1'
        $Level = 'L1'
        
        $Title= "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
		$Result.Source = "Group Policy Settings"

        #Find the Password History Size applied to this machine
        $EntryName = "LockoutDuration"
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
                $Number = '1.2.1'
                $Level = 'L1'
                $Result.Profile = "Domain Controller"
                $Title= "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                if ($FGPasswordPolicy.LockoutDuration -ge (New-TimeSpan -Minutes 15)) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
                $Result.Setting = [bool]$FGPasswordPolicy.LockoutDuration
                $Result.Entry = $FGPasswordPolicy
                $Return += $Result
            }
        }
    }

    end {
        return $Return
    }
}

<#
.SYNOPSIS
1.1.3 (L1) Ensure 'Minimum password age' is set to '1 or more day(s)'

.DESCRIPTION
This policy setting determines the number of days that you must use a password before you can change it. The range of values for this policy setting is between 1 and 999 days. (You may also set the value to 0 to allow immediate password changes.) The default value for this setting is 0 days.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PasswordPolicyMinPasswordAge

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.1.3      L1    Ensure 'Minimum password age' is set to '1 or more day(s)'      Group Policy Settings     True        
1.1.3      L1    Ensure 'Minimum password age' is set to '1 or more day(s)'      Test Policy Fine Grain... True        


.NOTES
General notes
#>
function Test-PasswordPolicyMinPasswordAge {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = "1.1.3"
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Minimum password age' is set to '1 or more day(s)'"
		$Result.Source = "Group Policy Settings"

        #Find the Password History Size applied to this machine
        $EntryName = "MinimumPasswordAge"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
        $Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Result.Setting -gt 0) {
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
                $Result.Number = '1.1.3'
                $Result.Level = "L1"
                $Result.Profile = "Domain Controller"
                $Result.Title = "Ensure 'Minimum password age' is set to '1 or more day(s)'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                $Result.Setting = $FGPasswordPolicy.MinPasswordAge
                if ($FGPasswordPolicy.MinPasswordAge -gt (New-TimeSpan -Days 0)) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
                $Result.Entry = $FGPasswordPolicy
                $Return += $Result
            }
        }
    }

    end {
        return $Return
    }

}

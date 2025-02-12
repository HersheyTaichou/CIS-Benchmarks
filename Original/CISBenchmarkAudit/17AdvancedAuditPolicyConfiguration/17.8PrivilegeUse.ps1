<#
.SYNOPSIS
17.8.1 (L1) Ensure 'Audit Sensitive Privilege Use' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports when a user account or service uses a sensitive privilege.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PrivilegeUseAuditSensitivePrivilegeUse

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
17.8.1     L1    Ensure 'Audit Sensitive Privilege Use' is set to 'Success an... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-PrivilegeUseAuditSensitivePrivilegeUse {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
              $EntryName = "Audit Sensitive Privilege Use"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.8.1"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Sensitive Privilege Use' is set to 'Success and Failure'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingValue
        if ($Result.Setting -eq 3) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

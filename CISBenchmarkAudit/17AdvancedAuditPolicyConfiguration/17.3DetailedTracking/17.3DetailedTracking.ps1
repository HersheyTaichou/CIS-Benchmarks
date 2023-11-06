<#
.SYNOPSIS
17.3.1 (L1) Ensure 'Audit PNP Activity' is set to include 'Success'

.DESCRIPTION
This policy setting allows you to audit when plug and play detects an external device.

.EXAMPLE
Test-DetailedTrackingAuditPNPActivity

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.3.1     (L1) Ensure 'Audit PNP Activity' is set to include 'Success'                Group Policy Settings     True  

.NOTES
General notes
#>
function Test-DetailedTrackingAuditPNPActivity {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
              $EntryName = "Audit PNP Activity"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.3.1"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit PNP Activity' is set to include 'Success'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingValue
        if (($Result.Setting -eq 1) -or ($Result.Setting -eq 3)) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
17.3.2 (L1) Ensure 'Audit Process Creation' is set to include 'Success'

.DESCRIPTION
This subcategory reports the creation of a process and the name of the program or user that created it.

.EXAMPLE
Test-DetailedTrackingAuditProcessCreation

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.3.2     (L1) Ensure 'Audit Process Creation' is set to include 'Success'            Group Policy Settings     True  

.NOTES
General notes
#>
function Test-DetailedTrackingAuditProcessCreation {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
              $EntryName = "Audit Process Creation"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.3.2"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Process Creation' is set to include 'Success'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingValue
        if (($Result.Setting -eq 1) -or ($Result.Setting -eq 3)) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
17.9.1 (L1) Ensure 'Audit IPsec Driver' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports on the activities of the Internet Protocol security (IPsec) driver.

.EXAMPLE
Test-SystemAuditIPsecDriver

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.9.1     (L1) Ensure 'Audit IPsec Driver' is set to 'Success and Failure'            Group Policy Settings     True  

.NOTES
General notes
#>
function Test-SystemAuditIPsecDriver {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit IPsec Driver"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.9.1"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit IPsec Driver' is set to 'Success and Failure'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
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
        
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
17.9.2 (L1) Ensure 'Audit Other System Events' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports on other system events

.EXAMPLE
Test-SystemAuditOtherSystemEvents

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.9.2     (L1) Ensure 'Audit Other System Events' is set to 'Success and Failure'     Group Policy Settings     True  

.NOTES
General notes
#>
function Test-SystemAuditOtherSystemEvents {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit Other System Events"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.9.2"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Other System Events' is set to 'Success and Failure'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
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
        
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
17.9.3 (L1) Ensure 'Audit Security State Change' is set to include 'Success'

.DESCRIPTION
This subcategory reports changes in security state of the system, such as when the security subsystem starts and stops.

.EXAMPLE
Test-SystemAuditSecurityStateChange

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.9.3     (L1) Ensure 'Audit Security State Change' is set to include 'Success'       Group Policy Settings     True  

.NOTES
General notes
#>
function Test-SystemAuditSecurityStateChange {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit Security State Change"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.9.3"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Security State Change' is set to include 'Success'"
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
        
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
17.9.4 (L1) Ensure 'Audit Security System Extension' is set to include 'Success'

.DESCRIPTION
This subcategory reports the loading of extension code such as authentication packages by the security subsystem.

.EXAMPLE
Test-SystemAuditSecuritySystemExtension

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.9.4     (L1) Ensure 'Audit Security System Extension' is set to include 'Success'   Group Policy Settings     True  

.NOTES
General notes
#>
function Test-SystemAuditSecuritySystemExtension {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit Security System Extension"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.9.4"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Security System Extension' is set to include 'Success'"
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
        
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
17.9.5 (L1) Ensure 'Audit System Integrity' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports on violations of integrity of the security subsystem.

.EXAMPLE
Test-SystemAuditSystemIntegrity

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.9.5     (L1) Ensure 'Audit System Integrity' is set to 'Success and Failure'        Group Policy Settings     True  

.NOTES
General notes
#>
function Test-SystemAuditSystemIntegrity {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit System Integrity"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.9.5"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit System Integrity' is set to 'Success and Failure'"
		$Result.Source = "Group Policy Settings"

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
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
        
        $Return += $Result

        Return $Return
    }
}

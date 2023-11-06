<#
.SYNOPSIS
17.1.1 (L1) Ensure 'Audit Credential Validation' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports the results of validation tests on credentials submitted for a user account logon request.

.EXAMPLE
Test-AccountLogonAuditCredentialValidation

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.1.1     (L1) Ensure 'Audit Credential Validation' is set to 'Success and Failure'   Group Policy Settings     True  

.NOTES
General notes
#>
function Test-AccountLogonAuditCredentialValidation {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Audit Credential Validation"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.1.1"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Credential Validation' is set to 'Success and Failure'"
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
        return $Result
    }
}

<#
.SYNOPSIS
17.1.2 (L1) Ensure 'Audit Kerberos Authentication Service' is set to 'Success and Failure' (DC Only)

.DESCRIPTION
This subcategory reports the results of events generated after a Kerberos authentication TGT request.

.EXAMPLE
Test-AccountLogonAuditKerberosAuthenticationService

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.1.2     (L1) Ensure 'Audit Kerberos Authentication Service' is set to 'Success a... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-AccountLogonAuditKerberosAuthenticationService {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Audit Kerberos Authentication Service"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.1.2"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Kerberos Authentication Service' is set to 'Success and Failure' (DC Only)"
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
        return $Result
    }
}

<#
.SYNOPSIS
17.1.3 (L1) Ensure 'Audit Kerberos Service Ticket Operations' is set to 'Success and Failure' (DC Only)

.DESCRIPTION
This subcategory reports the results of events generated by Kerberos authentication ticket-granting ticket (TGT) requests.

.EXAMPLE
Test-AccountLogonAuditKerberosServiceTicketOperations

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.1.3     (L1) Ensure 'Audit Kerberos Service Ticket Operations' is set to 'Succes... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-AccountLogonAuditKerberosServiceTicketOperations {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Audit Kerberos Service Ticket Operations"
        $Result = [CISBenchmark]::new()
        $Result.Number = "17.1.3"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit Kerberos Service Ticket Operations' is set to 'Success and Failure' (DC Only)"
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
        return $Result
    }
}

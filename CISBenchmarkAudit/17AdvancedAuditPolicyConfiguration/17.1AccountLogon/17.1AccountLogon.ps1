function Test-AccountLogonAuditCredentialValidation {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Credential Validation"
        $RecommendationNumber = '17.1.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Credential Validation' is set to 'Success and Failure'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName"
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if ($Setting -eq 3) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-AccountLogonAuditKerberosAuthenticationService {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Kerberos Authentication Service"
        $RecommendationNumber = '17.1.2'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Audit Kerberos Authentication Service' is set to 'Success and Failure' (DC Only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName"
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if ($Setting -eq 3) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

function Test-AccountLogonAuditKerberosServiceTicketOperations {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Kerberos Service Ticket Operations"
        $RecommendationNumber = '17.1.3'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Audit Kerberos Service Ticket Operations' is set to 'Success and Failure' (DC Only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName"
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if ($Setting -eq 3) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

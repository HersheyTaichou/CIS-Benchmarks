<#
.SYNOPSIS
17.4.1 (L1) Ensure 'Audit Directory Service Access' is set to include 'Failure' (DC only)

.DESCRIPTION
This subcategory reports when an AD DS object is accessed. Only objects with SACLs cause audit events to be generated, and only when they are accessed in a manner that matches their SACL. These events are similar to the directory service access events in previous versions of Windows Server.

.EXAMPLE
Test-DSAccessAuditDirectoryServiceAccess

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.4.1     (L1) Ensure 'Audit Directory Service Access' is set to include 'Failure'... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-DSAccessAuditDirectoryServiceAccess {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit Directory Service Access"
        $RecommendationNumber = '17.4.1'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Audit Directory Service Access' is set to include 'Failure' (DC only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if (($Setting -eq 2) -or ($Setting -eq 3)) {
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

<#
.SYNOPSIS
17.4.2 (L1) Ensure 'Audit Directory Service Changes' is set to include 'Success' (DC only)

.DESCRIPTION
This subcategory reports changes to objects in Active Directory Domain Services (AD DS). The types of changes that are reported are create, modify, move, and undelete operations that are performed on an object.

.EXAMPLE
Test-DSAccessAuditDirectoryServiceChanges

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.4.2     (L1) Ensure 'Audit Directory Service Changes' is set to include 'Success... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-DSAccessAuditDirectoryServiceChanges {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = "Audit Directory Service Changes"
        $RecommendationNumber = '17.4.2'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Audit Directory Service Changes' is set to include 'Success' (DC only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName" -GPResult $GPResult
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if (($Setting -eq 1) -or ($Setting -eq 3)) {
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

<#
.SYNOPSIS
2.2.4 Ensure 'Act as part of the operating system' is set to 'No One'

.DESCRIPTION
This policy setting allows a process to assume the identity of any user and thus gain access to the resources that the user is authorized to access.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeTcbPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.4      L1    Ensure 'Act as part of the operating system' is set to 'No One' Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeTcbPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $Result.Number = '2.2.4'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Act as part of the operating system' is set to 'No One'"
        $Result.Source = 'Group Policy Settings'

        $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeTcbPrivilege" -Definition @("") -gpresult $GPResult
    }
    process {
        $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
        $Result.Setting = $UserRightsAssignment.Setting
    }

    end {
        return $Result
    }
}

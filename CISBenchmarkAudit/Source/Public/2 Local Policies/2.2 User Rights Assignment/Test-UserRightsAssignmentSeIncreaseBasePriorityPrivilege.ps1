<#
.SYNOPSIS
2.2.33 Ensure 'Increase scheduling priority' is set to 'Administrators, Window Manager\Window Manager Group'

.DESCRIPTION
This policy setting determines whether users can increase the base priority class of a process. (It is not a privileged operation to increase relative priority within a priority class.) This user right is not required by administrative tools that are supplied with the operating system but might be required by software development tools.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeIncreaseBasePriorityPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.33     L1    Ensure 'Increase scheduling priority' is set to 'Administrat... Group Policy Settings     True        

.NOTES
The benchmark specifies 'Administrators' and 'Window Manager\Window Manager Group' for 2019 and newer, but on a fresh install of Server 2022 promoted to a DC, 'Window Manager\Window Manager Group' does not come up in any searches. It was moved to be considered optional by the script.
#>
function Test-UserRightsAssignmentSeIncreaseBasePriorityPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.33'
    $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Increase scheduling priority' is set to 'Administrators, Window Manager\Window Manager Group'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeIncreaseBasePriorityPrivilege" -Definition @('Administrators') -OptionalDef @('Window Manager\Window Manager Group') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

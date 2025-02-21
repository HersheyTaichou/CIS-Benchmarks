<#
.SYNOPSIS
2.2.37 Ensure 'Manage auditing and security log' is set to 'Administrators' and (when Exchange is running in the environment) 'Exchange Servers' (DC only)
2.2.38 Ensure 'Manage auditing and security log' is set to 'Administrators' (MS only)

.DESCRIPTION
This policy setting determines which users can change the auditing options for files and directories and clear the Security log.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeSecurityPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.37     L1    Ensure 'Manage auditing and security log' is set to 'Adminis... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeSecurityPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Administrators')
        $DCOptional = @('Exchange Servers')
        $MemberServer = @('Administrators')
    }

    process {
        if ($ProductType.Number -eq 2) {
            $Number = '2.2.37'
            $Level = 'L1'
            $Result.Profile = "Domain Controller"
            $Title= "Ensure 'Manage auditing and security log' is set to 'Administrators' and (when Exchange is running in the environment) 'Exchange Servers' (DC only)"
            $Source = 'FixMe'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeSecurityPrivilege" -Definition $DomainController -OptionalDef $DCOptional -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType.Number -eq 3) {
            $Number = '2.2.38'
            $Level = 'L1'
            $Result.Profile = "Member Server"
            $Title= "Ensure 'Manage auditing and security log' is set to 'Administrators' (MS only)"
            $Source = 'FixMe'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeSecurityPrivilege" -Definition $MemberServer -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }
    end {
        return $Result
    }
}

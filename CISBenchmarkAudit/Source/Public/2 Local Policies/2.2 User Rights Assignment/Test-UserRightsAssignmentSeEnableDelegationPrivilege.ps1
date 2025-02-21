<#
.SYNOPSIS
2.2.27 Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'Administrators' (DC only)
2.2.28 Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'No One' (MS only)

.DESCRIPTION
This policy setting allows users to change the Trusted for Delegation setting on a computer object in Active Directory. Abuse of this privilege could allow unauthorized users to impersonate other users on the network.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeEnableDelegationPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.27     L1    Ensure 'Enable computer and user accounts to be trusted for ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeEnableDelegationPrivilege {
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
        $MemberServer = @("")
    }

    process {
        if ($ProductType.Number -eq 2) {
            $Number = '2.2.27'
            $Level = 'L1'
            $Result.Profile = "Domain Controller"
            $Title= "Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'Administrators' (DC only)"
            $Source = 'FixMe'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeEnableDelegationPrivilege" -Definition $DomainController -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType.Number -eq 3) {
            $Number = '2.2.28'
            $Level = 'L1'
            $Result.Profile = "Member Server"
            $Title= "Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'No One' (MS only)"
            $Source = 'FixMe'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeEnableDelegationPrivilege" -Definition $MemberServer -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }
    end {
        return $Result
    }
}

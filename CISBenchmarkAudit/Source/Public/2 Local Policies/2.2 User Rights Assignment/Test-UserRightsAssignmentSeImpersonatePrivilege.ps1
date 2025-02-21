<#
.SYNOPSIS
2.2.31 Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' (DC only)
2.2.32 Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' and (when the Web Server (IIS) Role with Web Services Role Service is installed) 'IIS_IUSRS' (MS only)

.DESCRIPTION
The policy setting allows programs that run on behalf of a user to impersonate that user (or another specified account) so that they can act on behalf of the user. If this user right is required for this kind of impersonation, an unauthorized user will not be able to convince a client to connect—for example, by remote procedure call (RPC) or named pipes—to a service that they have created to impersonate that client, which could elevate the unauthorized user's permissions to administrative or system levels.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeImpersonatePrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.31     L1    Ensure 'Impersonate a client after authentication' is set to... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeImpersonatePrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Administrators', 'LOCAL SERVICE', 'NETWORK SERVICE', 'SERVICE')
        $MemberServer = @('Administrators', 'LOCAL SERVICE', 'NETWORK SERVICE', 'SERVICE')
        $MSOptional = @('IIS_IUSRS')
    }

    process {
        if ($ProductType.Number -eq 2) {
            $Result.Number = '2.2.31'
            $Result.Level = "L1"
            $Result.Profile = "Domain Controller"
            $Result.Title = "Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' (DC only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeImpersonatePrivilege" -Definition $DomainController -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType.Number -eq 3) {
            $Result.Number = '2.2.32'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' and (when the Web Server (IIS) Role with Web Services Role Service is installed) 'IIS_IUSRS' (MS only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeImpersonatePrivilege" -Definition $MemberServer -OptionalDef $MSOptional -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }
    end {
        return $Result
    }
}

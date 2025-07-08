<#
.SYNOPSIS
2.2.1 Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'

.DESCRIPTION
This security setting is used by Credential Manager during Backup and Restore. No accounts should have this user right, as it is only assigned to Winlogon. Users' saved credentials might be compromised if this user right is assigned to other entities.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeTrustedCredManAccessPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.1      L1    Ensure 'Access Credential Manager as a trusted caller' is se... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeTrustedCredManAccessPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Number = "2.2.1"
        $Level = "L1"
        $Title = "Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'"
        $Setting = $SecEditReport.'Privilege Rights'.SeTrustedCredManAccessPrivilege.Split(',') | ForEach-Object {Get-AccountFromSid $_.Replace('*','').Replace(' ','') } -Join ','
    }

    process {
        if ($null -eq $Setting) {
            $SetCorrectly = $true
        } else {
            $SetCorrectly = $false
        }
        $Result = [CISBenchmark]::new(@{
            'Number' = $Number
            'Level' = $Level
            'Profile' = $ProductType.Profile
            'Title' = $Title
            'Source' = "Secedit"
            'Setting' = $Setting
            'SetCorrectly' = $SetCorrectly
        })
    }
    
    end {
        return $Result
    }
}
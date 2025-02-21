<#
.SYNOPSIS
2.2.17 Ensure 'Create symbolic links' is set to 'Administrators' (DC only)
2.2.18 Ensure 'Create symbolic links' is set to 'Administrators, NT VIRTUAL MACHINE\Virtual Machines' (MS only)

.DESCRIPTION
This policy setting determines which users can create symbolic links. In Windows Vista, existing NTFS file system objects, such as files and folders, can be accessed by referring to a new kind of file system object called a symbolic link. A symbolic link is a pointer (much like a shortcut or .lnk file) to another file system object, which can be a file, folder, shortcut or another symbolic link. The difference between a shortcut and a symbolic link is that a shortcut only works from within the Windows shell. To other programs and applications, shortcuts are just another file, whereas with symbolic links, the concept of a shortcut is implemented as a feature of the NTFS file system.

The recommended state for this setting is: Administrators and (when the Hyper-V Role is installed) NT VIRTUAL MACHINE\Virtual Machines.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeCreateSymbolicLinkPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.17     L1    Ensure 'Create symbolic links' is set to 'Administrators' (D... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeCreateSymbolicLinkPrivilege {
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
        $MemberServer = @('Administrators')
        $MSOptional = @('NT VIRTUAL MACHINE\Virtual Machines')
    }

    process {
        if ($ProductType.Number -eq 2) {
            $Result = [CISBenchmark]::new()
            $Number = '2.2.17'
            $Level = 'L1'
            if ($ProductType.Number -eq 1) {
                $Result.Profile = "Corporate/Enterprise Environment"
            } elseif ($ProductType.Number -eq 2) {
                $Result.Profile = "Domain Controller"
            } elseif ($ProductType.Number -eq 3) {
                $Result.Profile = "Member Server"
            }
            $Title= "Ensure 'Create symbolic links' is set to 'Administrators' (DC only)"
            $Result.Source = "Group Policy Settings"
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeCreateSymbolicLinkPrivilege" -Definition $DomainController -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType.Number -eq 3) {
            $Number = '2.2.18'
            $Level = 'L1'
            $Result.Profile = "Member Server"
            $Title= "Ensure 'Create symbolic links' is set to 'Administrators, NT VIRTUAL MACHINE\Virtual Machines' (MS only)"
            $Source = 'FixMe'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeCreateSymbolicLinkPrivilege" -Definition $MemberServer -OptionalDef $MSOptional -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }

    end {
        return $Result
    }
}

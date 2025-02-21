<#
.SYNOPSIS
18.10.3.1 (L2) Ensure 'Allow a Windows app to share application data between users' is set to 'Disabled'

.DESCRIPTION
Manages a Windows app's ability to share data between users who have installed the app. Data is shared through the SharedLocal folder. This folder is available through the Windows.Storage API.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE


Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-AppPackageDeploymentAllowSharedLocalAppData {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Allow a Windows app to share application data between users"
        $Result = [CISBenchmark]::new()
        $Number = '18.10.3.1'
        $Level = 'L2'
        
        $Title= "Ensure 'Allow a Windows app to share application data between users' is set to 'Disabled'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.State
        if ($Result.Setting -eq "Disabled") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

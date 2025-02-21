<#
.SYNOPSIS
18.8.1.1 (L2) Ensure 'Turn off notifications network usage' is set to 'Enabled'

.DESCRIPTION
This policy setting blocks applications from using the network to send notifications to update tiles, tile badges, toast, or raw notifications.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NotificationsNoCloudApplicationNotification

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-NotificationsNoCloudApplicationNotification {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Turn off notifications network usage"
        $Result = [CISBenchmark]::new()
        $Number = '18.8.1.1'
        $Level = 'L2'
        
        $Title= "Ensure 'Turn off notifications network usage' is set to 'Enabled'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.State
        if ($Result.Setting -eq "Enabled") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

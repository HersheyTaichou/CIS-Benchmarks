<#
.SYNOPSIS
18.10.93.4.1 (L1) Ensure 'Manage preview builds' is set to 'Disabled'

.DESCRIPTION
This policy setting manage which updates that are receive prior to the update being released.

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
function Test-ManageUpdatesOfferedFromWindowsUpdateManagePreviewBuildsPolicyValue {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Manage preview builds"
        $Result = [CISBenchmark]::new()
        $Number = '18.10.93.4.1'
        $Level = 'L1'
        
        $Title= "Ensure 'Manage preview builds' is set to 'Disabled'"
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

<#
.SYNOPSIS
18.10.93.4.2 (L1) Ensure 'Select when Preview Builds and Feature Updates are received' is set to 'Enabled: 180 or more days'

.DESCRIPTION
This policy setting determines when Preview Build or Feature Updates are received.

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
function Test-ManageUpdatesOfferedFromWindowsUpdateDeferFeatureUpdates {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Select when Preview Builds and Feature Updates are received"
        $Result = [CISBenchmark]::new()
        $Number = '18.10.93.4.2'
        $Level = 'L1'
        
        $Title= "Ensure 'Select when Preview Builds and Feature Updates are received' is set to 'Enabled: 180 or more days'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $AutomaticUpdates = $Result.Entry.Numeric | Where-Object {$_.Name -eq "How many days after a Feature Update is released would you like to defer the update before it is offered to the device?"}
        $Result.Setting = $AutomaticUpdates.Value
        if ($Result.Setting -eq "180" -and $Result.Entry.State -eq "Enabled") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
18.10.93.4.3 (L1) Ensure 'Select when Quality Updates are received' is set to 'Enabled: 0 days'

.DESCRIPTION


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
function Test-ManageUpdatesOfferedFromWindowsUpdateDeferQualityUpdates {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Select when Quality Updates are received"
        $Result = [CISBenchmark]::new()
        $Number = '18.10.93.4.3'
        $Level = 'L1'
        
        $Title= "Ensure 'Select when Quality Updates are received' is set to 'Enabled: 0 days'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $AutomaticUpdates = $Result.Entry.Numeric | Where-Object {$_.Name -eq "After a quality update is released, defer receiving it for this many days:"}
        $Result.Setting = $AutomaticUpdates.Value
        if ($Result.Setting -eq "0" -and $Result.Entry.State -eq "Enabled") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

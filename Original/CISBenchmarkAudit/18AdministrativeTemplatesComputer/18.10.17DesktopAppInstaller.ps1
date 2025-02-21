<#
.SYNOPSIS
18.10.17.1 (L1) Ensure 'Enable App Installer' is set to 'Disabled'

.DESCRIPTION
This policy setting controls whether user have access to the Windows Package Manager. Windows Package Manager is a package manager solution that consists of a command line tool and set of services for installing applications on Microsoft Windows Server 2019 (or newer).

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
function Test-DesktopAppInstallerEnableAppInstaller {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Enable App Installer"
        $Result = [CISBenchmark]::new()
        $Number = '18.10.17.1'
        $Level = 'L1'
        
        $Title= "Ensure 'Enable App Installer' is set to 'Disabled'"
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
18.10.17.2 (L1) Ensure 'Enable App Installer Experimental Features' is set to 'Disabled'

.DESCRIPTION
This policy setting controls whether users can enable experimental features in the Windows Package Manager.

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
function Test-DesktopAppInstallerEnableExperimentalFeatures {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Enable App Installer Experimental Features"
        $Result = [CISBenchmark]::new()
        $Number = '18.10.17.2'
        $Level = 'L1'
        
        $Title= "Ensure 'Enable App Installer Experimental Features' is set to 'Disabled'"
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
18.10.17.3 (L1) Ensure 'Enable App Installer Hash Override' is set to 'Disabled'

.DESCRIPTION
This policy setting controls whether or not users can override the SHA256 security validation in the Windows Package Manager settings.

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
function Test-DesktopAppInstallerEnableHashOverride {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Enable App Installer Hash Override"
        $Result = [CISBenchmark]::new()
        $Number = '18.10.17.3'
        $Level = 'L1'
        
        $Title= "Ensure 'Enable App Installer Hash Override' is set to 'Disabled'"
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
18.10.17.4 (L1) Ensure 'Enable App Installer ms-appinstaller protocol' is set to 'Disabled'

.DESCRIPTION
This policy setting controls whether users can install packages from a website that is using the ms-appinstaller protocol. The ms-appinstaller protocol allows users to install an application by clicking a link on a website.

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
function Test-DesktopAppInstallerEnableMSAppInstallerProtocol {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Enable App Installer ms-appinstaller protocol"
        $Result = [CISBenchmark]::new()
        $Number = '18.10.17.4'
        $Level = 'L1'
        
        $Title= "Ensure 'Enable App Installer ms-appinstaller protocol' is set to 'Disabled'"
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

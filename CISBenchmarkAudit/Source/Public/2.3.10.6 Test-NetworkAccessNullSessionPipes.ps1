<#
.SYNOPSIS
2.3.10.8 (L1) Configure 'Network access: Remotely accessible registry paths' is configured

.DESCRIPTION
This policy setting determines which registry paths will be accessible over the network, regardless of the users or groups listed in the access control list (ACL) of the winreg registry key.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessAllowedExactPaths

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.8   L1    Configure 'Network access: Remotely accessible registry path... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessAllowedExactPaths {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedExactPaths\Machine"
        $Number = '2.3.10.8'
        $Level = 'L1'
        
        $Title= "Configure 'Network access: Remotely accessible registry paths' is configured"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.SettingStrings.Value
        $Definition = @('System\CurrentControlSet\Control\ProductOptions','System\CurrentControlSet\Control\Server Applications','Software\Microsoft\Windows NT\CurrentVersion')
        if ($Result.Entry) {
            if (-not(Compare-Object -ReferenceObject $Definition -DifferenceObject $Result.Setting)) {
                $Result.SetCorrectly = $true
            } else {
                $Result.SetCorrectly = $false
            }
        } else  {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

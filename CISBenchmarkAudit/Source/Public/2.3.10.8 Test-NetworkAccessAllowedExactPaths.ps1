<#
.SYNOPSIS
2.3.10.9 (L1) Configure 'Network access: Remotely accessible registry paths and sub-paths' is configured

.DESCRIPTION
This policy setting determines which registry paths and sub-paths will be accessible over the network, regardless of the users or groups listed in the access control list (ACL) of the winreg registry key.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessAllowedPaths

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.9   L1    Configure 'Network access: Remotely accessible registry path... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessAllowedPaths {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedPaths\Machine"
        $Number = '2.3.10.9'
        $Level = 'L1'
        
        $Title= "Configure 'Network access: Remotely accessible registry paths and sub-paths' is configured"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.SettingStrings.Value
        $definition = @('System\CurrentControlSet\Control\Print\Printers','System\CurrentControlSet\Services\Eventlog','Software\Microsoft\OLAP Server','Software\Microsoft\Windows NT\CurrentVersion\Print','Software\Microsoft\Windows NT\CurrentVersion\Windows','System\CurrentControlSet\Control\ContentIndex','System\CurrentControlSet\Control\Terminal Server','System\CurrentControlSet\Control\Terminal Server\UserConfig','System\CurrentControlSet\Control\Terminal Server\DefaultUserConfiguration','Software\Microsoft\Windows NT\CurrentVersion\Perflib','System\CurrentControlSet\Services\SysmonLog')
        $ADCS = $definition + 'System\CurrentControlSet\Services\CertSvc'
        $WINS = $definition + 'System\CurrentControlSet\Services\WINS'
        $ADCSWins = $ADCS + 'System\CurrentControlSet\Services\WINS'

        if ($Result.Entry) {
            if (-not(Compare-Object -ReferenceObject $definition -DifferenceObject $Result.Setting)) {
                $Result.SetCorrectly = $true
            } elseif (-not(Compare-Object -ReferenceObject $ADCS -DifferenceObject $Result.Setting)) {
                $Result.SetCorrectly = $true
            } elseif (-not(Compare-Object -ReferenceObject $WINS -DifferenceObject $Result.Setting)) {
                $Result.SetCorrectly = $true
            } elseif (-not(Compare-Object -ReferenceObject $ADCSWins -DifferenceObject $Result.Setting)) {
                $Result.SetCorrectly = $true
            } else {
                $Result.SetCorrectly = $false
            }
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

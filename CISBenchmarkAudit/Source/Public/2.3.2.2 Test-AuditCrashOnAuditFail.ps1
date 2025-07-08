<#
.SYNOPSIS
2.3.2.2 (L1) Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether the system shuts down if it is unable to log Security events. It is a requirement for Trusted Computer System Evaluation Criteria (TCSEC)-C2 and Common Criteria certification to prevent auditable events from occurring if the audit system is unable to log them.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AuditCrashOnAuditFail

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.2.2    L1    Ensure 'Audit: Shut down system immediately if unable to log... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AuditCrashOnAuditFail {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\CrashOnAuditFail"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        if ($Result.Entry) {
            $Result.SetCorrectly = -not($Result.Setting)
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Number = '2.3.2.2'
        $Level = 'L1'
        
        $Title= "Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Disabled'"
        $Source = 'FixMe'
        return $Result
    }
}

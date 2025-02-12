<#
.SYNOPSIS
2.3.2.1 (L1) Ensure 'Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings' is set to 'Enabled'

.DESCRIPTION
This policy setting allows administrators to enable the more precise auditing capabilities present in Windows Vista and later.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-AuditSCENoApplyLegacyAuditPolicy

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.2.1    L1    Ensure 'Audit: Force audit policy subcategory settings (Wind... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-AuditSCENoApplyLegacyAuditPolicy {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\SCENoApplyLegacyAuditPolicy"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
    }

    process {
        if ($Result.Entry) {
            $Result.SetCorrectly = $Result.Setting
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        $Result.Number = '2.3.2.1'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'
        return $Result
    }
}

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
        $Result.Number = '2.3.2.2'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Disabled'"
        $Result.Source = 'Group Policy Settings'
        return $Result
    }
}

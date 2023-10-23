<#
.SYNOPSIS
2.3.2.1 (L1) Ensure 'Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings' is set to 'Enabled'

.DESCRIPTION
This policy setting allows administrators to enable the more precise auditing capabilities present in Windows Vista and later.

.EXAMPLE
Test-AuditSCENoApplyLegacyAuditPolicy

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.2.1   (L1) Ensure 'Audit: Force audit policy subcategory settings (Windows Vista or later) to override... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AuditSCENoApplyLegacyAuditPolicy {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\SCENoApplyLegacyAuditPolicy"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
        [bool]$Setting = [int]$Entry.SettingNumber
    }

    process {
        if ($Setting) {
            $Pass = $Setting
        } else {
            $Pass = $false
        }
    }

    end {
        $RecommendationNumber = '2.3.2.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings' is set to 'Enabled'"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.2.2 (L1) Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether the system shuts down if it is unable to log Security events. It is a requirement for Trusted Computer System Evaluation Criteria (TCSEC)-C2 and Common Criteria certification to prevent auditable events from occurring if the audit system is unable to log them.

.EXAMPLE
Test-AuditCrashOnAuditFail

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.2.2   (L1) Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Di... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-AuditCrashOnAuditFail {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\CrashOnAuditFail"
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
        [bool]$Setting = [int]$Entry.SettingNumber
    }

    process {
        if ($Entry) {
            if ($Setting) {
                $Pass = $false
            } elseif ($setting -eq $false) {
                $Pass = $true
            } else {
                $Pass = $false
            }
        } else {
            $Pass = $false
        }
    }

    end {
        $RecommendationNumber = '2.3.2.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Disabled'"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

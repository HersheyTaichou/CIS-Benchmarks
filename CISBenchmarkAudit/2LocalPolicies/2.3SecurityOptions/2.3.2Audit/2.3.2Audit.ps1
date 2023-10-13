function Test-AuditSCENoApplyLegacyAuditPolicy {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\SCENoApplyLegacyAuditPolicy"
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
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
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
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

function Test-AuditCrashOnAuditFail {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\CrashOnAuditFail"
        $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "KeyName"
        [bool]$Setting = [int]$Entry.SettingNumber
    }

    process {
        if ($Setting) {
            $Pass = $false
        } elseif ($setting -eq $false) {
            $Pass = $true
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
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
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

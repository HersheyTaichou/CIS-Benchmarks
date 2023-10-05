function Test-AuditSCENoApplyLegacyAuditPolicy {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\SCENoApplyLegacyAuditPolicy"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.KeyName -eq $EntryName) {
                    [bool]$Setting = $Entry.SettingNumber
                }
            }
        }
    }

    process {
        $result = $setting
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.2.1'
            'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings' is set to 'Enabled'"
            'Source' = 'Group Policy Settings'
            'Result'= $result
            'Setting' = $Setting
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

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\CrashOnAuditFail"
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.SecurityOptions) {
                If ($Entry.KeyName -eq $EntryName) {
                    [bool]$Setting = $Entry.SettingNumber
                }
            }
        }
    }

    process {
        $result = $setting
    }

    end {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.3.2.2'
            'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Disabled'"
            'Source' = 'Group Policy Settings'
            'Result'= $result
            'Setting' = $Setting
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

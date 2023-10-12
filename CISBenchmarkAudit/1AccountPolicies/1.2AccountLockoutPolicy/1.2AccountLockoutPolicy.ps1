<#
.SYNOPSIS
1.2.1 (L1) Ensure 'Account lockout duration' is set to '15 or more minute(s)'

.DESCRIPTION
The command checks the applied domain policy and any fine grained
password policies, to ensure they all meet the lockout duration requirement.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-AccountLockoutPolicyLockoutDuration {
    [CmdletBinding()]
    param ()
    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.2.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "LockoutDuration"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "Account" -KeyName "Name"
        $Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -ge "15") {
            $result = $true
        } else {
            $result = $false
        }

        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                if ($FGPasswordPolicy.LockoutDuration -ge (New-TimeSpan -Minutes 15)) {
                    $result = $true
                } else {
                    $result = $false
                }

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'RecommendationNumber'= $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'RecommendationName'= $RecommendationName
                    'Source' = $Source
                    'Result'= $result
                    'Setting' = [bool]$FGPasswordPolicy.LockoutDuration
                    'Entry' = $FGPasswordPolicy
                }
                $Properties.PSTypeNames.Add('psCISBenchmark')
                $Return += $Properties
            }
        }
    }

    end {
        return $Return
    }
}

<#
.SYNOPSIS
1.2.2 (L1) Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'

.DESCRIPTION
The command checks the applied domain policy and any fine grained
password policies, to ensure they all meet the lockout threshold requirement.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-AccountLockoutPolicyLockoutThreshold {
    [CmdletBinding()]
    param ()
    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.2.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "LockoutBadCount"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "Account" -KeyName "Name"
        $Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -gt "0" -and $Setting -le "5") {
            $result = $true
        } else {
            $result = $false
        }

        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                if ($FGPasswordPolicy.LockoutThreshold -gt "0" -and $FGPasswordPolicy.LockoutThreshold -le "5") {
                    $result = $true
                } else {
                    $result = $false
                }

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'RecommendationNumber'= $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'RecommendationName'= $RecommendationName
                    'Source' = $Source
                    'Result'= $result
                    'Setting' = [bool]$FGPasswordPolicy.LockoutThreshold
                    'Entry' = $FGPasswordPolicy
                }
                $Properties.PSTypeNames.Add('psCISBenchmark')
                $Return += $Properties
            }
        }
    }

    end {
        return $Return
    }
}

<#
.SYNOPSIS
1.2.3 (L1) Ensure 'Allow Administrator account lockout' is set to 'Enabled'

.DESCRIPTION
The command checks the applied domain policy to ensure that the admin account
lockout is enabled.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-AccountLockoutPolicyAdminLockout {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()

        #Find the maximum password age applied to this machine
        $EntryName = "AllowAdministratorLockout"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "Account" -KeyName "Name"
        [string]$Setting = $Entry.SettingBoolean
    }

    process {
        if ($Setting -eq "true") {
            $result = $true
            $Setting = $true
        } elseif ($Setting -eq "false") {
            $result = $false
            $Setting = $false
        } else {
            $result = $false
            $Setting = ""
        }

        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '1.2.3'
            'ProfileApplicability' = @("Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Allow Administrator account lockout' is set to 'Enabled'"
            'Source' = 'Group Policy Settings'
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties
    }

    end {
        return $Return
    }
}

<#
.SYNOPSIS
1.2.4 (L1) Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'

.DESCRIPTION
The command checks the applied domain password policy and any fine grained
password policies, to ensure they all meet the reset lockout count requirement.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-AccountLockoutPolicyResetLockoutCount {
    [CmdletBinding()]
    param ()
    begin {
        # Check the product type
        $ProductType = Get-ProductType
        $Return = @()
        $RecommendationNumber = '1.2.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'"
        $Source = 'Group Policy Settings'

        #Find the Password History Size applied to this machine
        $EntryName = "ResetLockoutCount"
        $Entry = Get-GPOEntry -EntryName $EntryName -SectionName "Account" -KeyName "Name"
        $Setting = [int]$Entry.SettingNumber
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        if ($Setting -ge "15") {
            $result = $true
        } else {
            $result = $false
        }

        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Result'= $result
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                if ($FGPasswordPolicy.LockoutObservationWindow -ge (New-TimeSpan -Minutes 15)) {
                    $result = $true
                } else {
                    $result = $false
                }

                $Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"

                $Properties = [PSCustomObject]@{
                    'RecommendationNumber'= $RecommendationNumber
                    'ProfileApplicability' = $ProfileApplicability
                    'RecommendationName'= $RecommendationName
                    'Source' = $Source
                    'Result'= $result
                    'Setting' = [bool]$FGPasswordPolicy.LockoutObservationWindow
                    'Entry' = $FGPasswordPolicy
                }
                $Properties.PSTypeNames.Add('psCISBenchmark')
                $Return += $Properties
            }
        }
    }

    end {
        return $Return
    }
}
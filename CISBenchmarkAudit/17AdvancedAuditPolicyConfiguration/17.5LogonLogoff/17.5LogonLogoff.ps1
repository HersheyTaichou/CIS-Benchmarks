<#
.SYNOPSIS
17.5.1 (L1) Ensure 'Audit Account Lockout' is set to include 'Failure'

.DESCRIPTION
This subcategory reports when a user's account is locked out as a result of too many failed logon attempts.

.EXAMPLE
Test-LogonLogoffAuditAccountLockout

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.5.1     (L1) Ensure 'Audit Account Lockout' is set to include 'Failure'             Group Policy Settings     True  

.NOTES
General notes
#>
function Test-LogonLogoffAuditAccountLockout {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Account Lockout"
        $RecommendationNumber = '17.5.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Account Lockout' is set to include 'Failure'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName"
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if (($Setting -eq 2) -or ($Setting -eq 3)) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
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
17.5.2 (L1) Ensure 'Audit Group Membership' is set to include 'Success'

.DESCRIPTION
This policy allows you to audit the group membership information in the user’s logon token. Events in this subcategory are generated on the computer on which a logon session is created. For an interactive logon, the security audit event is generated on the computer that the user logged on to. For a network logon, such as accessing a shared folder on the network, the security audit event is generated on the computer hosting the resource.

.EXAMPLE
Test-LogonLogoffAuditGroupMembership

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.5.2     (L1) Ensure 'Audit Group Membership' is set to include 'Success'            Group Policy Settings     True  

.NOTES
General notes
#>
function Test-LogonLogoffAuditGroupMembership {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Group Membership"
        $RecommendationNumber = '17.5.2'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Group Membership' is set to include 'Success'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName"
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if (($Setting -eq 1) -or ($Setting -eq 3)) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
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
17.5.3 (L1) Ensure 'Audit Logoff' is set to include 'Success'

.DESCRIPTION
This subcategory reports when a user logs off from the system. These events occur on the accessed computer.

.EXAMPLE
Test-LogonLogoffAuditLogoff

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.5.3     (L1) Ensure 'Audit Logoff' is set to include 'Success'                      Group Policy Settings     True  

.NOTES
General notes
#>
function Test-LogonLogoffAuditLogoff {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Logoff"
        $RecommendationNumber = '17.5.3'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Logoff' is set to include 'Success'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName"
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if (($Setting -eq 1) -or ($Setting -eq 3)) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
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
17.5.4 (L1) Ensure 'Audit Logon' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports when a user attempts to log on to the system. These events occur on the accessed computer.

.EXAMPLE
Test-LogonLogoffAuditLogon

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.5.4     (L1) Ensure 'Audit Logon' is set to 'Success and Failure'                   Group Policy Settings     True  

.NOTES
General notes
#>
function Test-LogonLogoffAuditLogon {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Logon"
        $RecommendationNumber = '17.5.4'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Logon' is set to 'Success and Failure'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName"
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if ($Setting -eq 3) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
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
17.5.5 (L1) Ensure 'Audit Other Logon/Logoff Events' is set to 'Success and Failure'

.DESCRIPTION
This subcategory reports other logon/logoff-related events, such as Remote Desktop Services session disconnects and reconnects, using RunAs to run processes under a different account, and locking and unlocking a workstation.

.EXAMPLE
Test-LogonLogoffAuditOtherLogonLogoffEvents

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.5.5     (L1) Ensure 'Audit Other Logon/Logoff Events' is set to 'Success and Fai... Group Policy Settings     True  

.NOTES
General notes
#>
function Test-LogonLogoffAuditOtherLogonLogoffEvents {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Other Logon/Logoff Events"
        $RecommendationNumber = '17.5.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Other Logon/Logoff Events' is set to 'Success and Failure'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName"
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if ($Setting -eq 3) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
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
17.5.6 (L1) Ensure 'Audit Special Logon' is set to include 'Success'

.DESCRIPTION
This subcategory reports when a special logon is used. A special logon is a logon that has administrator-equivalent privileges and can be used to elevate a process to a higher level.

.EXAMPLE
Test-LogonLogoffAuditSpecialLogon

Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  
17.5.6     (L1) Ensure 'Audit Special Logon' is set to include 'Success'               Group Policy Settings     True  

.NOTES
General notes
#>
function Test-LogonLogoffAuditSpecialLogon {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "Audit Special Logon"
        $RecommendationNumber = '17.5.6'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Audit Special Logon' is set to include 'Success'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SubcategoryName"
    }

    process {
        $Setting = [int]$Entry.SettingValue
        if (($Setting -eq 1) -or ($Setting -eq 3)) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
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

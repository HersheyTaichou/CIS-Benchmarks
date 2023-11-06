<#
.SYNOPSIS
18.3.1 (L1) Ensure LAPS AdmPwd GPO Extension / CSE is installed (MS only)

.DESCRIPTION


.EXAMPLE


Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  

.NOTES
General notes
#>
function Test-LAPS {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = ""
        $RecommendationNumber = '18.3.1'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure LAPS AdmPwd GPO Extension / CSE is installed (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        
    }

    end {
        
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
18.3.2 (L1) Ensure 'Do not allow password expiration time longer than required by policy' is set to 'Enabled' (MS only)

.DESCRIPTION


.EXAMPLE


Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  

.NOTES
General notes
#>
function Test-LAPS {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = ""
        $RecommendationNumber = '18.3.1'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Do not allow password expiration time longer than required by policy' is set to 'Enabled' (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        
    }

    end {
        
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
18.3.3 (L1) Ensure 'Enable Local Admin Password Management' is set to 'Enabled' (MS only)

.DESCRIPTION


.EXAMPLE


Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  

.NOTES
General notes
#>
function Test-LAPS {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = ""
        $RecommendationNumber = '18.3.1'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Enable Local Admin Password Management' is set to 'Enabled' (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        
    }

    end {
        
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
18.3.4 (L1) Ensure 'Password Settings: Password Complexity' is set to 'Enabled: Large letters + small letters + numbers + special characters' (MS only)

.DESCRIPTION


.EXAMPLE


Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  

.NOTES
General notes
#>
function Test-LAPS {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = ""
        $RecommendationNumber = '18.3.1'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Password Settings: Password Complexity' is set to 'Enabled: Large letters + small letters + numbers + special characters' (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        
    }

    end {
        
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
18.3.5 (L1) Ensure 'Password Settings: Password Length' is set to 'Enabled: 15 or more' (MS only)

.DESCRIPTION


.EXAMPLE


Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  

.NOTES
General notes
#>
function Test-LAPS {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = ""
        $RecommendationNumber = '18.3.1'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Password Settings: Password Length' is set to 'Enabled: 15 or more' (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        
    }

    end {
        
        $Return += $Result

        Return $Return
    }
}

<#
.SYNOPSIS
18.3.6 (L1) Ensure 'Password Settings: Password Age (Days)' is set to 'Enabled: 30 or fewer' (MS only)

.DESCRIPTION


.EXAMPLE


Number     Name                                                                        Source                    Pass  
------     ----                                                                        ------                    ----  

.NOTES
General notes
#>
function Test-LAPS {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Return = @()
        $EntryName = ""
        $RecommendationNumber = '18.3.1'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Password Settings: Password Age (Days)' is set to 'Enabled: 30 or fewer' (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        
    }

    end {
        
        $Return += $Result

        Return $Return
    }
}

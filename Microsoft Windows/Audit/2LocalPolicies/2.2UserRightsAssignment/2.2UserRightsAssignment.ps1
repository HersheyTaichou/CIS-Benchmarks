function Test-LockoutDuration {
    [CmdletBinding()]
    param (
        [Parameter()][bool]$FineGrainedPasswordPolicy
    )

    $Return = @()

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    #Find the lockout duration applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "LockoutDuration") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark
    # This setting is required for Level 1 compliance.

    if ($Setting -ge "15") {
        $Message = "1.2.1 The GPO account lockout duration is set to " + $Setting + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "1.2.1 The GPO account lockout duration is set to " + $Setting + " and does not meet the requirement. Increase the policy to 24 or greater."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '1.2.1'
        'ConfigurationProfile' = "Level 1"
        'RecommendationName'= "Ensure 'Account lockout duration' is set to '15 or more minute(s)'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

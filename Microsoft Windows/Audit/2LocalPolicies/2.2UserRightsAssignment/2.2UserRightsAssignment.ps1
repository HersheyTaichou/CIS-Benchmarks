function Test-UserRightsAssignmentSettingName {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    #Find the lockout duration applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.Account) {
            If ($Entry.Name -eq "") {
                [int]$Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    if ($Setting -ge "15") {
        $Message = "2.2.1" + $Setting + " and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message = "2.2.1" + $Setting + " and does not meet the requirement."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.2.1'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= ""
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

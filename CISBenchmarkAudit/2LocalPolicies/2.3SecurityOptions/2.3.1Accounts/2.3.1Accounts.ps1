function Test-AccountsNoConnectedUser {
    [CmdletBinding()]
    param ()

    $Return = @()

    # If not already present, run GPResult.exe and store the result in a variable
    if (-not($script:gpresult)) {
        $script:gpresult = Get-GPResult
    }

    # Check the current value of the setting
    $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\NoConnectedUser"
    foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.SecurityOptions) {
            If ($Entry.KeyName -eq $EntryName) {
                $Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    if ($Setting -eq 3) {
        $result = $true
    } else {
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.3.1'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'"
        'Source' = 'Group Policy Settings'
        'Result'= $Result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

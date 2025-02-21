function Get-RegistryReport {
    [CmdletBinding()]
    param (
        # Registry key path
        [Parameter(Mandatory)]
        [string]
        $Path
    )

    begin {
        $Keys = Get-ChildItem -Recurse -Path $Path -ErrorAction SilentlyContinue
    }

    process {
        $Registry = foreach ($Key in $Keys) {
            [Microsoft.Win32.RegistryKey]$regItem = Get-Item -Path "Registry::$Key" -ErrorAction Stop

            if ($regItem.Property.Count -gt 0) {
                foreach ($property in $regItem.Property) {
                    [pscustomobject]@{
                        'Path'  = $regItem
                        'Name'  = $property
                        'Value' = $regItem.GetValue($property, $null, 'DoNotExpandEnvironmentNames')
                        'Type'  = $regItem.GetValueKind($property)
                        'Computername' = $env:computername
                    }
                }
            } else {
                [pscustomobject]@{
                    'Path'         = $regItem
                    'Name'         = '(Default)'
                    'Value'        = $null
                    'Type'         = 'String'
                    'Computername' = $env:computername
                }
            }
        }
    }

    end {
        Return $Registry
    }
}
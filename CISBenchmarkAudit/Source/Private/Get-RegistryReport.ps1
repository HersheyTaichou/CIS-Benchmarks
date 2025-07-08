function Get-RegistryReport {
    [CmdletBinding()]
    param (
        # Registry key path
        [Parameter(Mandatory)]
        [string[]]
        $Path
    )

    begin {
        
        $Keys = foreach ($Location in $Path) {
            Get-ChildItem -Recurse -Path $Location -ErrorAction SilentlyContinue
        }
    }

    process {
        $Registry = foreach ($Key in $Keys) {
            foreach ($property in $Key.Property) {
                if ($property -ne "(default)") {
                    [pscustomobject]@{
                        'Path'  = $Key.Name
                        'Name'  = $property
                        'Value' = $Key.GetValue($property, $null, 'DoNotExpandEnvironmentNames')
                        'Type'  = $Key.GetValueKind($property)
                        'Computername' = $env:computername
                    }
                } else {
                    [pscustomobject]@{
                        'Path'         = $Key
                        'Name'         = $property
                        'Value'        = $null
                        'Type'         = 'String'
                        'Computername' = $env:computername
                    }
                }
            }
        }
    }

    end {
        Return $Registry
    }
}
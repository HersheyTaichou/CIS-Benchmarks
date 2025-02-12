<#
.SYNOPSIS
Get the product type

.DESCRIPTION
Get and return the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Get-ProductType

Domain Controller

.NOTES
General notes
#>
function Get-ProductType {
    [CmdletBinding()]
    param ()

    begin {
        [int]$ProductType = (Get-CimInstance -ClassName Win32_OperatingSystem).ProductType
    }

    process {
        $Return = switch ($ProductType) {
            1 {
                @{
                    'Number' = $ProductType
                    'Profile' = "Workstation"
                }
            }
            2 {
                @{
                    'Number' = $ProductType
                    'Profile' = "Domain Controller"
                }
            }
            3 {
                @{
                    'Number' = $ProductType
                    'Profile' = "Member Server"
                }
            }
            Default {
                @{
                    'Number' = $ProductType
                    'Profile' = "Unknown"
                }
            }
        }
    }

    end {
        return $Return
    }
}

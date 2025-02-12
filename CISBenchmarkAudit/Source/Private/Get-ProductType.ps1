<#
.SYNOPSIS
Get the product type

.DESCRIPTION
Get and return the product type:

1 = Corporate/Enterprise Environment
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
        switch ($ProductType) {
            1 {
                $CISProfile = "Corporate/Enterprise Environment"
            }
            2 {
                $CISProfile = "Domain Controller"
            }
            3 {
                $CISProfile = "Member Server"
            }
            Default {
                $CISProfile = $ProductType
            }
        }
    }

    end {
        return $CISProfile
    }
}

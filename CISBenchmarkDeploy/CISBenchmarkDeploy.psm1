#Requires -RunAsAdministrator

function Add-CISBenchmarkGPO {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory)]
        [String]
        $Name
    )
    
    begin {
        if (Get-GPO -Name $Name -ErrorAction SilentlyContinue) {
            Write-Host "GPO exists"
        } Else {
            Write-Host "GPO does not exist"
        }
    }
    
    process {
        
    }
    
    end {
        
    }
}
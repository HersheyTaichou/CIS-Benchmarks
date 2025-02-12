function Get-SeceditReport {
    [CmdletBinding()]
    param ()
    
    begin {
        $Secedit  = "C:\Windows\System32\secedit.exe"
        $TempFileName = [System.IO.Path]::GetTempFileName()
        $Area = "SECURITYPOLICY"
    }
    
    process {
        If (-Not (Test-Path $Secedit)) {
            Write-Error "$Secedit is required and was not found."
        } else {
            &$Secedit /export /cfg $TempFileName /areas $Area | Out-Null
            $Data = Get-IniContent $TempFileName
        }
    }
    
    end {
        return $Data
    }
}
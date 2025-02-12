function Get-SeceditReport {
    [CmdletBinding()]
    param ()
    
    begin {
        $Secedit  = "C:\Windows\System32\secedit.exe"
        $TempFileName = [System.IO.Path]::GetTempFileName()
        $Area = "SECURITYPOLICY"
    }
    
    process {
        If (-Not (Test-Path $BinarySecedit)) {
            Write-Error "$Secedit is required and was not found."
        } else {
            &$BinarySecedit /export /cfg $TempFileName /areas $Area | Out-Null
            $Data = Get-IniContent $TempFileName
        }
    }
    
    end {
        return $Data
    }
}
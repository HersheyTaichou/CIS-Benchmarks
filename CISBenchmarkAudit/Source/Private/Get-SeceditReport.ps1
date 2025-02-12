function Get-SecEditReport {
    [CmdletBinding()]
    param ()
    
    begin {
        $SecEdit  = "C:\Windows\System32\SecEdit.exe"
        $TempFileName = [System.IO.Path]::GetTempFileName()
        $Area = "SECURITYPOLICY"
    }
    
    process {
        If (-Not (Test-Path $SecEdit)) {
            Write-Error "$SecEdit is required and was not found."
        } else {
            &$SecEdit /export /cfg $TempFileName /areas $Area | Out-Null
            $Data = Get-IniContent $TempFileName
        }
    }
    
    end {
        return $Data
    }
}
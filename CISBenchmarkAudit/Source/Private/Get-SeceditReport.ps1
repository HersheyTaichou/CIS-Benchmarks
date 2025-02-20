function Get-SecEditReport {
    [CmdletBinding()]
    param ()

    begin {
        $SecEdit  = "C:\Windows\System32\SecEdit.exe"
        $TempFileName = [System.IO.Path]::GetTempFileName()
    }

    process {
        If (-Not (Test-Path $SecEdit)) {
            Write-Error "$SecEdit is required and was not found."
        } else {
            &$SecEdit /export /cfg $TempFileName | Out-Null
            $Data = Get-IniContent $TempFileName
        }
    }

    end {
        Remove-Item $TempFileName
        return $Data
    }
}
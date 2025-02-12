<#
.SYNOPSIS
Read a .ini file into embedded hashtables

.DESCRIPTION
Converts a .ini file into a hashtable array

.PARAMETER filePath
Path to the .ini file

.EXAMPLE
Get-IniContent "test.ini"

.NOTES
Original source: https://devblogs.microsoft.com/scripting/use-powershell-to-work-with-any-ini-file/
#>
Function Get-IniContent ($filePath) {
    $ini = @{}
    switch -regex -file $FilePath {
        "^\[(.+)\]" {
            # Section
            $section = $matches[1]
            $ini[$section] = @{}
            $CommentCount = 0
        }
        "^(;.*)$" {
            # Comment
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = "Comment" + $CommentCount
            $ini[$section][$name] = $value
        }
        "(.+?)\s*=(.*)" {
            # Key
            $name, $value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }

    return $ini
}

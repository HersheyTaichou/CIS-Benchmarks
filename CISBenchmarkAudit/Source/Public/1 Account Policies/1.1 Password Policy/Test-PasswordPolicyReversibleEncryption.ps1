<#
.SYNOPSIS
1.1.7 (L1) Ensure 'Store passwords using reversible encryption' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether the operating system stores passwords in a way that uses reversible encryption, which provides support for application protocols that require knowledge of the user's password for authentication purposes. Passwords that are stored with reversible encryption are essentially the same as plaintext versions of the passwords.

This command will also check any configured Fine Grained Password Policies, to confirm compliance.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-PasswordPolicyReversibleEncryption

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.1.7      L1    Ensure 'Store passwords using reversible encryption' is set ... Group Policy Settings     True        
1.1.7      L1    Ensure 'Store passwords using reversible encryption' is set ... Test Policy Fine Grain... True        

.NOTES
General notes
#>
function Test-PasswordPolicyReversibleEncryption {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Return = @()
        $Result = [CISBenchmark]::new()
        $Result.Number = "1.1.7"
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Store passwords using reversible encryption' is set to 'Disabled'"
        $Result.Source = "Group Policy Settings"

        #Find the Password History Size applied to this machine
        $EntryName = "ClearTextPassword"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        # Check if the GPO setting meets the CIS Benchmark
        $Result.Setting = [System.Convert]::ToBoolean($Result.Entry.SettingBoolean)
        $Result.SetCorrectly = -not($Result.Setting)

        
        $Return += $Result

        # Check if the Fine Grained Password Policies meet the CIS Benchmark
        if ($ProductType.Number -eq 2) {
            $ADFineGrainedPasswordPolicy = Get-ADFineGrainedPasswordPolicy -filter *
            foreach ($FGPasswordPolicy in $ADFineGrainedPasswordPolicy) {
                $Result = [CISBenchmark]::new()
                $Result.Number = '1.1.7'
                $Result.Level = "L1"
                $Result.Profile = "Domain Controller"
                $Result.Title = "Ensure 'Store passwords using reversible encryption' is set to 'Disabled'"
                $Result.Source = $FGPasswordPolicy.Name + " Fine Grained Password Policy"
                $Result.Setting = $FGPasswordPolicy.ReversibleEncryptionEnabled
                
                $Result.SetCorrectly = -not([bool]$FGPasswordPolicy.ReversibleEncryptionEnabled)
                $Result.Entry = $FGPasswordPolicy

                $Return += $Result
            }
        }
    }

    end {
        return $Return
    }
}

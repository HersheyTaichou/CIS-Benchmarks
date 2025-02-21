<# 
class CISControl {
    [int]$Version # The control version
    [string]$Control # The title of the control
    [int]$ImplementationGroup # Level this control is applicable to

    CISControl() { $this.Init(@{}) }

    CISControl([hashtable]$Properties) { $this.Init($Properties) }

    [void] Init([hashtable]$Properties) {
        foreach ($Property in $Properties.Keys) {
            $this.$Property = $Properties.$Property
        }
    }

}
#>

class CISBenchmark {
    [string]$Number # The number of the benchmark
    [string]$Level # Level 1, 2 or Next Generation Windows Security
    [string]$Profile # Domain Controller or Member Server
    [string]$Title # The title of the recommendation
    [string]$Source # Where the setting was checked from
    [bool]$SetCorrectly # if it is set correctly
    $Setting # The current setting
    #[CISControl]$CISControl
    hidden $Entry # The XML output of the setting

    CISBenchmark() { $this.Init(@{}) }

    CISBenchmark([hashtable]$Properties) { $this.Init($Properties) }

    [void] Init([hashtable]$Properties) {
        foreach ($Property in $Properties.Keys) {
            $this.$Property = $Properties.$Property
        }
    }

}
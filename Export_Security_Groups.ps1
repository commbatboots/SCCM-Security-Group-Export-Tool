Param (
    [Parameter(Mandatory=$true)][String]$Export
)

$Groups         = Get-ADGroup -filter 'Name -like "sg-sccm-*"'
$Groups         = $Groups.Name
$Exluded        = $Groups | where {$_ -like "*Excluded*"}
$Pilot          = $Groups | where {$_ -like "*Pilot*"}
$Production     = $Groups | where {$_ -like "*Production*"}
$RebootSuppress = $Groups | where {$_ -like "*Reboot Suppress*"}
$Wave1          = $Groups | where {$_ -like "*Wave 1*"}
$WQL            = "SMS_R_System.SystemGroupName ="

#Arrays for WQL queiries
$Groups = 'Excluded','Pilot', 'Production', 'Reboot Suppress', 'Wave1'
$Excluded_Export       = @()
$Pilot_Export          = @()
$Production_Export     = @()
$RebootSuppress_Export = @()
$Wave1_Export          = @()
$Complete_Table        = [ordered]@{} 

#BEGIN

BEGIN {

    Write-Host "Compiling table.."

    foreach ($group in $Groups) {
        $Complete_Table.Add($group,@())
    }
    
    foreach ($group in $Exluded) {
        $Complete_Table["Excluded"] += $group
        $Excluded_Export += "and" + " " + '"' + $WQL + " " + $group + '"'
    
    }
    foreach ($group in $Pilot) {
        $Complete_Table["Pilot"] += $group
        $Pilot_Export += "and" + " " + '"' + $WQL + " " + $group + '"'
    
    }
    foreach ($group in $Production) {
        $Complete_Table["Production"] += $group
        $Production_Export += "and" + " " + '"' + $WQL + " " + $group + '"'
    
    }
    foreach ($group in $RebootSuppress) {
        $Complete_Table["Reboot Suppress"] += $group
        $RebootSuppress_Export += "and" + " " + '"' + $WQL + " " + $group + '"'
    
    }
    foreach ($group in $Wave1) {
        $Complete_Table["Wave1"] += $group
        $Wave1_Export += "and" + " " + '"' + $WQL + " " + $group + '"'
    
    }    
}

PROCESS {

}

END {
    
}

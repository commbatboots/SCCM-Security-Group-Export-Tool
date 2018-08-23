Param (
    [Parameter(Mandatory=$true)][String]$Export
)

$SCCMGroups = @()
$Groups = Get-ADGroup -filter 'Name -like "sg-sccm-*"'
$Groups = $Groups.Name
$Exluded        = $Groups | where {$_ -like "*Excluded*"}
$Pilot          = $Groups | where {$_ -like "*Pilot*"}
$Production     = $Groups | where {$_ -like "*Production*"}
$RebootSuppress = $Groups | where {$_ -like "*Reboot Suppress*"}
$Wave1          = $Groups | where {$_ -like "*Wave 1*"}
$WQL = "SMS_R_System.SystemGroupName ="

$Excluded_Export       = @()
$Pilot_Export          = @()
$Production_Export     = @()
$RebootSuppress_Export = @()
$Wave1_Export          = @()


foreach ($group in $Exluded) {
    $Excluded_Export += "and" + " " + '"' + $WQL + " " + $group + '"'
}
foreach ($group in $Pilot) {
    $Pilot_Export += "and" + " " + '"' + $WQL + " " + $group + '"'
}
foreach ($group in $Production) {
    $Production_Export += "and" + " " + '"' + $WQL + " " + $group + '"'
}
foreach ($group in $RebootSuppress) {
    $RebootSuppress_Export += "and" + " " + '"' + $WQL + " " + $group + '"'
}
foreach ($group in $Wave1) {
    $Wave1_Export += "and" + " " + '"' + $WQL + " " + $group + '"'
}

Write-Host "Exporting data to $Export" -ForegroundColor Yellow

Write-host "Exporting Excluded.." 
$Excluded_Export > "$Export\Excluded Workstations.txt"

Write-Host "Exporting Pilot" 
$Pilot_Export > "$Export\Pilot Workstations.txt"

Write-Host "Exporting Production" 
$Production_Export > "$Export\Production Workstations.txt"

Write-Host "Exporting Reboot Suppress" 
$RebootSuppress_Export > "$Export\Reboot Suppress Workstations.txt"

Write-Host "Exporting Wave 1" 
$Wav1_Export > "$Export\Wave 1 Workstations.txt"

Write-Host "Export complete" -ForegroundColor Yellow

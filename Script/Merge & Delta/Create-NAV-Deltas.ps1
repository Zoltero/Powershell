$currentDirectory = 'C:\Users\mso.ARMADA\Documents\Upgrade\OMA_Transport\'
#$currentDirectory = 'C:\Users\mso.ARMADA\Documents\Merge\navet'
$beforeUpdate = Join-Path -Path $currentDirectory -ChildPath 'BEFORE UPDATE\BEFOREUPDATE.txt' | Get-ChildItem
$afterUpdate = Join-Path -Path $currentDirectory -ChildPath 'AFTER UPDATE\AFTERUPDATE.txt' | Get-ChildItem
$deltaPath = Join-Path -Path $currentDirectory -ChildPath 'DELTA'
$reversedDeltaPath = Join-Path -Path $currentDirectory -ChildPath 'REVERSED DELTA'

Get-ChildItem $deltaPath -Include *.DELTA -File -Recurse | foreach {$_.Delete()}
Get-ChildItem $reversedDeltaPath -Include *.DELTA -File -Recurse | foreach {$_.Delete()}

#Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\90\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1" -Force
Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\100\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1" -Force

Compare-NAVApplicationObject -OriginalPath $beforeUpdate -ModifiedPath $afterUpdate -DeltaPath $deltaPath
Compare-NAVApplicationObject -OriginalPath $afterUpdate -ModifiedPath $beforeUpdate -DeltaPath $reversedDeltaPath
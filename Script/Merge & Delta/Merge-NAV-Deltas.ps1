cd C:\Users\mso.ARMADA\Documents\Upgrade\OMA_Transport
$targetPath = ".\target\*.txt"
$deltaPatch = ".\delta\*.*"
$resultPatch = ".\result"

Update-NAVApplicationObject -TargetPath $targetPath -DeltaPath $deltaPatch -ResultPath $resultPatch
Join-NAVApplicationObjectFile -Source .\result\*.txt -Destination .\Result_3.txt -force
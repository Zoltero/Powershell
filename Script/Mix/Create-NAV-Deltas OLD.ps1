cd C:\Users\mso.ARMADA\Documents\Upgrade\OMA_Transport
$beforeUpdate = ".\Before update\beforeupdate.txt"
$afterUpdate = ".\after update\afterupdate.txt"
$deltaPatch = ".\delta"
$reversedDeltaPatch = ".\reversed delta"

Compare-NAVApplicationObject -OriginalPath $beforeUpdate -ModifiedPath $afterUpdate -DeltaPath $deltaPatch
Compare-NAVApplicationObject -OriginalPath $afterUpdate -ModifiedPath $beforeUpdate -DeltaPath $reversedDeltaPatch

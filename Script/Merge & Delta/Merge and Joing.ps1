cd C:\Users\mso\Documents\Upgrade
Merge-NAVApplicationObject -OriginalPath .\ORIGINAL -TargetPath .\TARGET -ModifiedPath .\MODIFIED -ResultPath .\RESULT -DateTimeProperty FromModified -ModifiedProperty FromModified -force
Join-NAVApplicationObjectFile -Source .\Result\ConflictOriginal\*.Txt -Destination .\Conflict_1.txt -force
Join-NAVApplicationObjectFile -Source .\Result\ConflictModified\*.Txt -Destination .\Conflict_2.txt -force
Join-NAVApplicationObjectFile -Source .\Result\ConflictTarget\*.Txt -Destination .\Conflict_3.txt -force
Join-NAVApplicationObjectFile -Source .\Result\*.txt -Destination .\Result_3.txt -force
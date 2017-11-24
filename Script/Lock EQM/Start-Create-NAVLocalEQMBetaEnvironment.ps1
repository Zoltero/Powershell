# Import settings
. "C:\Users\mso.ARMADA\Documents\PowerShell\Script\Lock EQM\Set-NAVSettings.ps1"
. "C:\Users\mso.ARMADA\Documents\PowerShell\Script\Lock EQM\Remove-NAVEnvironment.ps1"
. "C:\Users\mso.ARMADA\Documents\PowerShell\Script\Lock EQM\Create-NAVServiceEnvironment.ps1"
. "C:\Users\mso.ARMADA\Documents\PowerShell\Script\Lock EQM\Create-NAVSQLEnvironment.ps1"

# Remove existing service and SQL
Remove-NAVLocalService -ServerInstance $localNAVServerInstance
Remove-NAVLocalSQL -SQLServerInstance $localSQLServerInstance -SQLServerDatabaseName $localSQLServerDatabaseName

# Backup SQL on Server
Backup-NAVSqlServer -fromSQLServer $fromSQLServer -FromSQLServerInstance $fromSQLServerInstance -BackupToFile $backupToFile

# Copy SQL backup from server
Copy-NAVSQLFromServer -fromSQLServer $fromSQLServer -backupToFile $backupToFile -WorkingDirectory $localWorkingDirectory -folderOnServer $randomFolderOnServer

# Create NAV SQL Database
Create-NAVSQLDatabase -SQLServerInstance $localSQLServerInstance -SQLServer $localSQLServer -ServiceAccount $localServiceAccount -BackupFile $localBackupFile -SQLServerDatabaseName $localSQLServerDatabaseName -DataFilesDestinationPath $DataFilesDestinationPath -LogFilesDestinationPath $LogFilesDestinationPath -timeOut $timeOut

# Create NAV Service
Create-NAVService -NAVServerInstance $localNAVServerInstance -ServiceAccount $localServiceAccount -SQLServerInstance $localSQLServerInstance -SQLServer $localSQLServer -SQLServerDatabaseName $localSQLServerDatabaseName

# Start NAV Service
Start-NAVService -NAVServerInstance $localNAVServerInstance

# Synchronize NAV Service
Synchronize-NAVService -NAVServerInstance localNAVServerInstance

# Set UidOffset
Set-NAVStartUidOffset -NAVServerInstance $localNAVServerInstance -navUidOffset $navUidOffset

Write-Host "Job done!"

Start-NAVIdeClient -ServerInstance $localNAVServerInstance

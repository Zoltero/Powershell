# Function
function Create-NAVSqlService
{
    [CmdletBinding()]
    Param(
        [String]$ServerInstance
    )

}

function Backup-NAVSqlServer
{
    [CmdletBinding()]
    Param(
        [String]$fromSQLServer,
        [String]$FromSQLServerInstance,
        [String]$BackupToFile
    )

    Write-Host -ForegroundColor Green "Creating SQL backup file on $fromSQLServer..."
    Backup-SqlDatabase -ServerInstance $fromSQLServerInstance -Database $fromSQLDatabaseName -BackupFile $backupToFile
}

function Copy-NAVSQLFromServer
{
    [CmdletBinding()]
    Param(
        [String]$fromSQLServer,
        [String]$backupToFile,
        [String]$WorkingDirectory,
        [String]$folderOnServer
    )
    Write-Host "Copying SQL backup file from $fromSQLServer..."
    Move-Item $backupToFile $WorkingDirectory

    Write-Host -ForegroundColor Yellow "Removing temporary files on $fromSQLServer..."
    Remove-Item -Path $folderOnServer -Recurse
}

function Create-NAVSQLDatabase
{
    [CmdletBinding()]
    Param(
        [String]$SQLServerInstance,
        [String]$SQLServer,
        [String]$ServiceAccount,
        [String]$BackupFile,
        [String]$SQLServerDatabaseName,
        [String]$DataFilesDestinationPath,
        [String]$LogFilesDestinationPath,
        [Int]$timeOut
    )

    Write-Host -ForegroundColor Green "Creating local SQL database on $SQLServer..."
    New-NAVDatabase `
        -FilePath $BackupFile `
        -DatabaseName $SQLServerDatabaseName `
        -DataFilesDestinationPath $DataFilesDestinationPath `
        -LogFilesDestinationPath $LogFilesDestinationPath `
        -DatabaseInstance $SQLServerInstance `
        -DatabaseServer $SQLServer `
        -ServiceAccount $ServiceAccount `
        -TimeOut $timeOut `
        -Force | Out-Null

    Write-Host -ForegroundColor Yellow "Removing SQL backup file on $SQLServer..."
    Remove-Item -Path $BackupFile
}

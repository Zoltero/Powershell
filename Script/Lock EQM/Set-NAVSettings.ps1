# SQL Server
$fromSQLServer = 'AD-SRV-11'
$fromSQLServerInstance = Join-Path -Path $fromSQLServer -ChildPath '\NAV2017'
$fromsqldatabasename = 'EQM100_W1_2017_BETA'

# Local settings
$localWorkingDirectory = 'C:\Dynamics NAV\TEMP\'
$LocalService = 'mso-surfacepro4/'

# Local SQL
$localSQLServer = 'mso-surfacepro4'
$localSQLServerInstance = 'SQL2016'
$localSQLServerDatabaseName = 'Local_EQM100_W1_2017_BETA'
$localSQLFolder = Join-Path -Path ${env:ProgramFiles} -ChildPath '\Microsoft SQL Server\MSSQL13.SQL2016\MSSQL\DATA\'

# Local Instance
$localNAVServerInstance = 'Local_EQM2017W1_BETA'
$localServiceAccount = 'ARMADA\mso'

# Local Credentials
#$localServiceAccountPW = ConvertTo-SecureString 'Oscar2481' -AsPlainText -Force
#$localServiceAccountCredentials = New-Object System.Management.Automation.PSCredential($localServiceAccount, $localServiceAccountPW)

$timeOut = 300
$navUidOffset = 15000600

$localSQLName_Mdf = $LocalSQLServerDatabaseName + '.mdf'
$localSQLName_Ldf = $LocalSQLServerDatabaseName + '.ldf'

$DataFilesDestinationPath = Join-Path -Path $LocalSQLFolder -ChildPath $localSQLName_Mdf
$LogFilesDestinationPath = Join-Path -Path $LocalSQLFolder -ChildPath $localSQLName_Ldf

# Backup file
$randomFileName = ([System.IO.Path]::GetRandomFileName()) + '.bak'
$randomFolderOnServer = Join-Path -Path ('\\' + $fromSQLServer + '\c$\') -ChildPath ([System.IO.Path]::GetRandomFileName())
New-Item $randomFolderOnServer -ItemType Directory | Out-Null

$backupToFile = Join-Path -Path $randomFolderOnServer -ChildPath $randomFileName
$localBackupFile = Join-Path -Path $localWorkingDirectory -ChildPath $randomFileName

# Import mudule
Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\100\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1" -force | Out-Null
Import-Module "${env:ProgramFiles}\Microsoft Dynamics NAV\100\Service\NavAdminTool.ps1" -force | Out-Null
Import-Module Cloud.Ready.Software.NAV -Force | Out-Null

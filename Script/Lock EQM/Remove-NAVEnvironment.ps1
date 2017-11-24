# Function
function Remove-NAVLocalService
{
    [CmdletBinding()]
    Param(
        [String]$ServerInstance
    )
    
    Write-Host -ForegroundColor Yellow "Search for NAV server instance $ServerInstance..."
    $ServerInstanceExists = Get-NAVServerInstance -ServerInstance $ServerInstance
    if ($ServerInstanceExists) {
        Write-Host -ForegroundColor Green " - Removing NAV server instance $ServerInstance..."
        Remove-NAVServerInstance -ServerInstance $ServerInstance -Force
    }
    else
    {
        write-host -ForegroundColor Yellow " - NAV server instance does not exist."
    }
}

Function Remove-NAVLocalSQL
{
    [CmdletBinding()]
    Param(
        [String]$SQLServerInstance,
        [String]$SQLServerDatabaseName
    )

    Write-Host -ForegroundColor Green "Dropping SQL server database $SQLServerDatabaseName..."
    Drop-SQLDatabaseIfExists -SQLServer $SQLServerInstance -Databasename $SQLServerDatabaseName

    #Write-Host -ForegroundColor Green "Dropping SQL server database $SQLServerDatabaseName..."
    #[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null
    #$smoServer = New-Object ('Microsoft.SqlServer.Management.Smo.Server') -argumentlist $SQLServerInstance
    #$smoServer.Databases | Select Name, Size, DataSpaceUsage, IndexSpaceUsage, SpaceAva
    #if ($smoServer.Databases[$SQLServerDatabaseName] -ne $null)  
    #    {  
    #    $smoServer.Databases[$SQLServerDatabaseName].drop()  
    #    } 
}
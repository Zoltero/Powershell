# Function
function Create-NAVService
{
    [CmdletBinding()]
    Param(
        [String]$NAVServerInstance,
        [String]$ServiceAccount,
        [String]$SQLServerInstance,
        [String]$SQLServer,
        [String]$SQLServerDatabaseName
    )

    $mgtServicesPort = 7065
    $clientServicesPort = 7066
    $soapServicesPort = 7067
    $odataServicesPost = 7068

    $localServiceAccountPW = ConvertTo-SecureString 'Oscar2481' -AsPlainText -Force
    $localServiceAccountCredentials = New-Object System.Management.Automation.PSCredential($ServiceAccount, $localServiceAccountPW)


    Write-Host "Creating new NAV server instance on $SQLServer..."
    New-NAVServerInstance `
        -ManagementServicesPort $mgtServicesPort `
        -ServerInstance $NAVServerInstance `
        -ClientServicesPort $clientServicesPort `
        -SOAPServicesPort $soapServicesPort `
        -ODataServicesPort $odataServicesPost `
        -ServiceAccount User `
        -ServiceAccountCredential $localServiceAccountCredentials `
        -DatabaseName $SQLServerDatabaseName `
        -DatabaseInstance $SQLServerInstance `
        -DatabaseServer $SQLServer `
        -Force
}

function Start-NAVService
{
    [CmdletBinding()]
    Param(
        [String]$NAVServerInstance
    )

    $ServerInstanceExists = Get-NAVServerInstance -ServerInstance $NAVServerInstance
    if ($ServerInstanceExists) {
        Write-Host "Starting new NAV server instance $NAVServerInstance..."
        Set-NAVServerInstance -ServerInstance $NAVServerInstance -Start -Force
    }
    else
    {
        Write-Host -ForegroundColor Yellow "Nav server instance $NAVServerInstance does not exist."
    }
}

function Synchronize-NAVService
{
    [CmdletBinding()]
    Param(
        [String]$NAVServerInstance
    )

    $ServerInstanceExists = Get-NAVServerInstance -ServerInstance $NAVServerInstance
    if ($ServerInstanceExists) {
        Write-Host "Synchronizing new NAV server instance $NAVServerInstance..."
        Sync-NAVTenant -ServerInstance $NAVServerInstance -Force
    }
}


function Set-NAVStartUidOffset
{
    [CmdletBinding()]
    Param(
        [String]$NAVServerInstance,
        [Int]$navUidOffset
    )

    $ServerInstanceExists = Get-NAVServerInstance -ServerInstance $NAVServerInstance
    if ($ServerInstanceExists) {
        Write-Host "Setting Start ID (UidOffset) to $navUidOffset..."
        Set-NAVUidOffset -ServerInstance $NAVServerInstance -UidOffSet $navUidOffset
    }
}

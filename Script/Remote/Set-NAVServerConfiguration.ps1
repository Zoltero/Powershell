Import-Module 'C:\Program Files\Microsoft Dynamics NAV\80\Service\Microsoft.Dynamics.Nav.Management.dll'

$RemoteMachine = "ad-srv-11"
$RemoteSession = New-PSSession -ComputerName $RemoteMachine
$ServiceName = "EQM80_W1_2015_DEV"

Invoke-Command $RemoteSession -ScriptBlock{
  Set-NAVServerConfiguration $ServiceName -KeyName EnableFullALFunctionTracing -KeyValue "true"
  Set-NAVServerInstance $ServiceName -Restart
}

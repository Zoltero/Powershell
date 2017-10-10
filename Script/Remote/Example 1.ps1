$RemoteServer = “ad-srv-11“
$MySession = New-PSSession $RemoteServer
Invoke-Command -Session $MySession -ScriptBlock{$i++;$i}
Invoke-Command -Session $MySession -ScriptBlock{$i++;$i}
Invoke-Command -Session $MySession -ScriptBlock{$i++;$i}
$properties = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()
$TcpConnections = $properties.GetActiveTcpConnections()

$clientport = 0; $mgtport = 0; $odataport = 0; $soapport = 0; $freeport = 0;

for ($freeport=6000;$freeport -le 7000; $freeport++){
	if( ($TcpConnections | Where-Object {$_.LocalEndPoint.Port -eq $freeport}).count -eq 0){
		if($clientport -eq 0){ $clientport = $freeport }
		elseif($mgtport -eq 0){ $mgtport = $freeport }
		elseif($odataport -eq 0){ $odataport = $freeport }
		elseif($soapport -eq 0){ $soapport = $freeport }
		else { break }
	}

}
write-host "Create NAV Service '$InstanceName' using clientport: $clientport mgtport: $mgtport odataport: $odataport soapport: $soapport"
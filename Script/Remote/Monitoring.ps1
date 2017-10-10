$RemoteMachine = "ad-srv-11"
 Copy-Item C:\temp\NAVAppProfiler.xml \\$RemoteMachine\c$\temp

 $RemoteSession = New-PSSession -ComputerName $RemoteMachine
 
 Invoke-Command $RemoteSession -ScriptBlock{
 $datacollectorset = New-Object -COM Pla.DataCollectorSet
 $TemplateFile = 'C:\temp\NAVAppProfiler.xml'
 $xml = Get-Content $TemplateFile
 $DataCollectorName = 'Microsoft Dynamics NAV Server Performance Monitor'
 
 $datacollectorset.SetXml($xml)
 $datacollectorset.Commit("$DataCollectorName",$null, 0x0003) | Out-Null
 
 #After creating the data collector, it will take some seconds before it is ready to start it
 do
 {
   $datacollectorset.start($false)
   sleep(3)
   Write-Host "Starting trace ..."
 
 }
 while ($datacollectorset.Status -eq 0)
 $datacollectorset.Status
 
 }

 
Invoke-Command $RemoteSession -ScriptBlock{
 
 $datacollectorset.Stop($false)
 sleep(5) #Give it time to stop before deleting it
 $datacollectorset.Delete()
 }
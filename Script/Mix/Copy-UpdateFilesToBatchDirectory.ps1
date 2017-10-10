<#
 .SYNOPSIS
 This cmdlet copies all the DVD files to create a batch ready set of files.
 .DESCRIPTION
 This cmdlet copies all the DVD files to create a batch ready set of files..
 It skips files that are not needed in installation scenarios such as .config files.
 .PARAMETER DvdDirectory
 Specifies the folder where the uncompressed Cumulative Update DVD subdirectory is located.
 .PARAMETER BatchDirectory
 Specifies the folder that must hold the result set of files, in other words the folder to copy to.
#>
function Copy-UpdateFilesToBatchDirectory
{
 [CmdletBinding()]
 param (
 [parameter(Mandatory=$true)]
 [string] $DvdDirectory,
[parameter(Mandatory=$true)]
 [string] $BatchDirectory
 )
 PROCESS
 {
 # Copy all the Dvd files to a _TEMP folder
 if (Test-Path -Path $DvdDirectory\"RoleTailoredClient\program files\Microsoft Dynamics NAV\80")
 {
 $NavVersion = "80"
 }
 elseif (Test-Path -Path $DvdDirectory\"RoleTailoredClient\program files\Microsoft Dynamics NAV\90")
 {
 $NavVersion = "90"
 }
 else
 {
 Write-Host Please check your DvdDirectory parameter
 return 
 }

Write-Verbose "Copying files from $DvdDirectory to $BatchDirectory\_Temp\..."
 New-Item -ItemType Directory -Force -Path $BatchDirectory\_Temp\RTC\Add-ins
 New-Item -ItemType Directory -Force -Path $BatchDirectory\_Temp\NST\Add-ins
 New-Item -ItemType Directory -Force -Path $BatchDirectory\_Temp\BPA
 New-Item -ItemType Directory -Force -Path $BatchDirectory\_Temp\"WEB CLIENT"
 New-Item -ItemType Directory -Force -Path $BatchDirectory\_Temp\OUTLOOK
 New-Item -ItemType Directory -Force -Path $BatchDirectory\_Temp\ADCS
 New-Item -ItemType Directory -Force -Path $BatchDirectory\_Temp\HelpServer
 New-Item -ItemType Directory -Force -Path $BatchDirectory\_Temp\UpgradeToolKit
 New-Item -ItemType Directory -Force -Path $BatchDirectory\_Temp\WindowsPowerShellScripts
 if ($NavVersion -eq "90")
 {
 New-Item -ItemType Directory -Force -Path $BatchDirectory\_Temp\CrmCustomization
 New-Item -ItemType Directory -Force -Path $BatchDirectory\_Temp\TestToolKit
 }

Copy-Item $DvdDirectory\"RoleTailoredClient\program files\Microsoft Dynamics NAV\"$NavVersion"\RoleTailored Client"\* -destination $BatchDirectory\_Temp\RTC -recurse -Force
 Copy-Item $DvdDirectory\"ServiceTier\program files\Microsoft Dynamics NAV\"$NavVersion"\Service"\* -destination $BatchDirectory\_Temp\NST -recurse -Force
 Copy-Item $DvdDirectory\BPA\* -destination $BatchDirectory\_Temp\BPA -recurse -Force
 Copy-Item $DvdDirectory\"WebClient\Microsoft Dynamics NAV\"$NavVersion"\Web Client"\* -destination $BatchDirectory\_Temp\"WEB CLIENT" -recurse -Force
 Copy-Item $DvdDirectory\"Outlook\program files\Microsoft Dynamics NAV\"$NavVersion"\OutlookAddin"\* -destination $BatchDirectory\_Temp\OUTLOOK -recurse -Force
 Copy-Item $DvdDirectory\"ADCS\program files\Microsoft Dynamics NAV\"$NavVersion"\Automated Data Capture System"\* -destination $BatchDirectory\_Temp\ADCS -recurse -Force
 Copy-Item $DvdDirectory\"HelpServer\DynamicsNAV"$NavVersion"Help"\* -destination $BatchDirectory\_Temp\HelpServer -recurse -Force
 Copy-Item $DvdDirectory\"UpgradeToolKit"\* -destination $BatchDirectory\_Temp\UpgradeToolKit -recurse -Force
 Copy-Item $DvdDirectory\"WindowsPowerShellScripts"\* -destination $BatchDirectory\_Temp\WindowsPowerShellScripts -recurse -Force
 if ($NavVersion -eq "90")
 {
 Copy-Item $DvdDirectory\"CrmCustomization"\* -destination $BatchDirectory\_Temp\CrmCustomization -recurse -Force
 Copy-Item $DvdDirectory\"TestToolKit"\* -destination $BatchDirectory\_Temp\TestToolKit -recurse -Force
 }
 Write-Verbose "Done copying files RTC files from $DvdDirectory to $BatchDirectory\_Temp."
 
 # Delete files that are not needed for an installation scenario
 Write-Verbose "Deleting files from $BatchDirectory that are not needed for the batch directory..."
Get-ChildItem $BatchDirectory\_Temp -include '*.chm' -Recurse | Remove-Item -force -ErrorAction SilentlyContinue
 Get-ChildItem $BatchDirectory\_Temp -include '*.hh' -Recurse | Remove-Item -force -ErrorAction SilentlyContinue
 Get-ChildItem $BatchDirectory\_Temp -include '*.config' -Recurse | Remove-Item -force -ErrorAction SilentlyContinue
 Get-ChildItem $BatchDirectory\_Temp -include '*.ico' -Recurse | Remove-Item -force -ErrorAction SilentlyContinue
 Get-ChildItem $BatchDirectory\_Temp -include '*.flf' -Recurse | Remove-Item -force -ErrorAction SilentlyContinue
 Get-ChildItem $BatchDirectory\_Temp -include '*.sln' -Recurse | Remove-Item -force -ErrorAction SilentlyContinue
 RemoveUnnecessaryDirectory (Join-Path $BatchDirectory\_Temp\RTC\ 'ENU')
 RemoveUnnecessaryDirectory (Join-Path $BatchDirectory\_Temp\RTC\ 'en-US')
 RemoveUnnecessaryDirectory (Join-Path $BatchDirectory\_Temp\RTC\ 'Images')
 RemoveUnnecessaryDirectory (Join-Path $BatchDirectory\_Temp\RTC\ 'SLT')
 RemoveUnnecessaryDirectory (Join-Path $BatchDirectory\_Temp\RTC\ 'ReportLayout')
 RemoveUnnecessaryDirectory (Join-Path $BatchDirectory\_Temp\BPA\ 'Scripts')
 RemoveUnnecessaryDirectory (Join-Path $BatchDirectory\_Temp\"WEB CLIENT"\ 'Resources')
 RemoveUnnecessaryDirectory (Join-Path $BatchDirectory\_Temp\HelpServer\ 'css')
 RemoveUnnecessaryDirectory (Join-Path $BatchDirectory\_Temp\HelpServer\ 'help')
 RemoveUnnecessaryDirectory (Join-Path $BatchDirectory\_Temp\HelpServer\ 'images')
 RemoveUnnecessaryDirectory (Join-Path $BatchDirectory\_Temp\WindowsPowerShellScripts\ 'ApplicationMergeUtilities')
 Write-Verbose "Done deleting files from $BatchDirectory that are not needed for for the batch directory."

# Copy the result to the requested directory and remove the _Temp folder
 Copy-Item $BatchDirectory\_Temp\* -destination $BatchDirectory\ -recurse -Force
 RemoveUnnecessaryDirectory (Join-Path $BatchDirectory\ '_Temp')
 }
}

function RemoveUnnecessaryDirectory
{
 param ([string]$directory)
 Remove-Item $directory -force -Recurse -ErrorAction SilentlyContinue
}
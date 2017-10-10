# load all 'autoload' scripts

#Test-Path $profile  ##Used to make sure profile doesn't already exist
#New-Item -path $profile -type file –force  ##Used to create the profile file. This file is the profile file

$choiceList = "201&5","2013 &R2", "201&3", "&Cancel"
$Caption = "Starting Powershell"
$Message = "Which NAV powershell model do you require?"
$Default = 0

$choicedesc = New-Object System.Collections.ObjectModel.Collection[System.Management.Automation.Host.ChoiceDescription] 
$choiceList | foreach  { $choicedesc.Add((New-Object "System.Management.Automation.Host.ChoiceDescription" -ArgumentList $_))}

Switch ($Host.ui.PromptForChoice($caption, $message, $choicedesc, $default))
{
    0 {
        Import-Module 'C:\Program Files (x86)\Microsoft Dynamics NAV\80\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1' -WarningAction SilentlyContinue | out-null
        Import-Module 'C:\Program Files\Microsoft Dynamics NAV\80\Service\NavAdminTool.ps1' -WarningAction SilentlyContinue | Out-Null
      }
    1 {
        Import-Module 'C:\Program Files\Microsoft Dynamics NAV\71\Service\NavAdminTool.ps1' -WarningAction SilentlyContinue | out-null
      }
    2 {
        Import-Module 'C:\Program Files\Microsoft Dynamics NAV\70\Service\NavAdminTool.ps1' -WarningAction SilentlyContinue | out-null
      }
} 
          
cls
Write-Host "Custom PowerShell Environment Loaded" 
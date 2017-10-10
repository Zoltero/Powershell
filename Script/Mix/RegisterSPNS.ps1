$ADNAVAdminUser = Get-ADUser $NAVAdmin.Username
$self = New-Object System.Security.Principal.SecurityIdentifier([Security.Principal.WellKnownSidType]"SelfSid", $ADNAVAdminUser.Sid.tostring())
$rule = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($self, [System.DirectoryServices.ActiveDirectoryRights]::WriteProperty, [System.Security.AccessControl.AccessControlType]"Allow")

$dn = $ADNAVAdminUser.DistinguishedName 
$U = [ADSI]"LDAP://$dn" 
$Result = $U.ObjectSecurity.AddAccessRule($rule)
$U.CommitChanges()
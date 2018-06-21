<#
    Tests dirsync permissions on the domain and configuration partition
#>

# Update with username and permission to check
$userName = "FABRIKAM\sppsync" 
$replicationPermissionName = "Replicating Directory Changes"





function Check-ADUserPermission(
    [System.DirectoryServices.DirectoryEntry]$entry, 
    [string]$user, 
    [string]$permission)
{
    $dse = [ADSI]"LDAP://Rootdse"
    $ext = [ADSI]("LDAP://CN=Extended-Rights," + $dse.ConfigurationNamingContext)

    $right = $ext.psbase.Children | 
        ? { $_.DisplayName -eq $permission }
    
    if($right -ne $null)
    {
        $perms = $entry.psbase.ObjectSecurity.Access |
            ? { $_.IdentityReference -eq $user } |
            ? { $_.ObjectType -eq [GUID]$right.RightsGuid.Value }

        return ($perms -ne $null)
    }
    else
    {
        Write-Warning "Permission '$permission' not found."
        return $false
    }
}



# Main()

$dse = [ADSI]"LDAP://Rootdse"

$entries = @(
    [ADSI]("LDAP://" + $dse.defaultNamingContext),
    [ADSI]("LDAP://" + $dse.configurationNamingContext));

Write-Host "User '$userName': "
foreach($entry in $entries)
{
    $result = Check-ADUserPermission $entry $userName $replicationPermissionName
    
    if($result)
    {
        Write-Host "`thas '$replicationPermissionName' permission on '$($entry.distinguishedName)'" `
            -ForegroundColor Green
    }
    else
    {
        Write-Host "`tdoes NOT have '$replicationPermissionName' permission on '$($entry.distinguishedName)'" `
            -ForegroundColor Red
    }
} 
#EOF
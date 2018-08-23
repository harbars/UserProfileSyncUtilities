<#
    Adds a user as a "Profile Leader" and displays the results
#>
If ((Get-PSSnapin -Name "Microsoft.SharePoint.PowerShell" -EA 0) -eq $null) { Add-PSSnapin -Name "Microsoft.SharePoint.PowerShell" }

$Account = "FABRIKAM\administrator"
$UpaProxyName = "User Profile Service Application Proxy"
$UpaProxy = Get-SPServiceApplicationProxy  | Where-Object {$_.Name -eq $UpaProxyName}

Add-SPProfileLeader $UpaProxy $Account

Get-SPProfileLeader $UpaProxy
#EOF